# .NET Solution Developer : Consuming REST API. 💻
This project were built in C# with MVC design pattern.

## Run and edit the project. 🚀
1) Install Visual Studio [here] (https://visualstudio.microsoft.com/es/downloads/) and install the individual component: .NET Framework project and item templates (Plantillas de proyecto y de elemento de .NET Framework). 

![image](https://user-images.githubusercontent.com/72401861/176335941-d9a138d4-f2da-462a-95f3-0c5266844157.png)

2) Clone this repository 
  ```https://github.com/dev-LuisSM/.NET-Solution-Developer-1-day-test.git```

3) Open the folder "MVC Web API REST" in Visual Studio.

4) Click on play icon ISS Express.

![image](https://user-images.githubusercontent.com/72401861/176335739-4703e3bc-1ecf-45e7-98ac-acec52a7ba39.png)


## The web application from inside. 📂
1) The controller (HomeController.cs)

- Here we call the API with an Asynchronous Task. All the information is sent to the View.

```CSharp
public async Task<ActionResult> Index()
{
    var httpClient = new HttpClient();
    var json = await httpClient.GetStringAsync("https://jsonplaceholder.typicode.com/photos");
    var photos = JsonConvert.DeserializeObject<List<Photos>>(json);

    return View(photos);
}
```

2) The Model (Photos.cs)

- We need to create the model for this to work, in this case, we create a Class called Photos, here we set all the getters and setters for the API.

```CSharp
public class Photos
{
    public int id { get; set; }
    public int albumId { get; set; } 
    public string title { get; set; }
    public string url { get; set; }
    public string thumbnailUrl { get; set; }
}
```

3) The view (Index.cshtml)

Here, the code is divided into two parts. 

- The HTML section. In this section, all the information is displayed, only with some divs.

```HTML
<div id="app">
    <h1>My Photo Gallery</h1>

    <div class="gallery" data-gallery></div>
    <div class="settings">
        <label for="itemsQty">Items per page:</label>
        <input type="number" min="1" max="5000" id="itemsQty" name="itemsQty" data-rows>
        <input type="button" value="Change quantity per page" data-button/>

        <div class="pageNumbers" data-pageNumbers></div>
    </div>
</div>
```
- The Js section. 
 
**In this section we manage all the data and the logic to display them.**
> * Converting the list that we receive from the Controller to have a better handling.
> * Getting the elements from the HTML.
> * Configuring the page and the elements per page.
```Javascript
const photoArray = @Html.Raw(Json.Encode(@Model));
const gallery = document.querySelector('[data-gallery]');
const pageNumber = document.querySelector('[data-pageNumbers]');
const rowPage = document.querySelector('[data-rows]');
const buttonChange = document.querySelector('[data-button]');

let current_page = 1;
let rows = 100;
```

**List display function**
> * Cleaning the page.
> * Obtaining the number of paginated images.
> * Setting the information in each subsequent node.
> * Iterating each element (Picture > a - img > p).
> * Adding child nodes.
```Javascript
const DisplayList = (items, wrapper, rows_per_page, page) => {
    wrapper.innerHTML = "";
    page--;

    let start = rows_per_page * page;
    let end = start + rows_per_page;
    let paginatedItems = items.slice(start, end);

    for (let i in paginatedItems) {
        let txt = paginatedItems[i].title;
        let imgSrc = paginatedItems[i].thumbnailUrl;
        let imgHref = paginatedItems[i].url;

        let picture = document.createElement('picture');
        let image = document.createElement('a');
        let thumbnail = document.createElement('img');
        let title = document.createElement('p');
        image.href = imgHref;
        image.setAttribute('target', '_blank');
        title.innerText = txt;
        thumbnail.src = imgSrc;

        image.appendChild(thumbnail);
        picture.appendChild(image);
        picture.appendChild(title);

        wrapper.appendChild(picture);
    }
};
```

**PageButton function**
> * Creation of the button element.
> * Adding the "active" class to identify the current page.
> * Removing the "active" class from the previous button and add it to the selected button.
```Javascript
const PaginationButton = (page, items) => {
    let button = document.createElement('button');
    button.innerText = page;

    if (current_page == page) button.classList.add('active');
    button.addEventListener('click', () => {
        current_page = page;
        DisplayList(items, gallery, rows, current_page);
        let current_btn = document.querySelector('button.active');
        current_btn.classList.remove('active');

        button.classList.add('active');
    });

    return button;
}
```


**SetupPagination Function**
> * Getting the number of pages.
> * Calling to the PaginationButton function to add it to the pageNumbers section.
```Javascript
const SetupPagination = (items, wrapper, rows_per_page) => {
    wrapper.innerHTML = "";

    let page_count = Math.ceil(items.length / rows_per_page);
    for (let i = 1; i < page_count + 1; i++) {
        let btn = PaginationButton(i, items);
        wrapper.appendChild(btn);
    }
}
```

**Update Function**
> * Obtaining the number of the rows specified in the input.
> * Calling the functions DisplayList and SetupPagination to update the page.
```Javascript
buttonChange.addEventListener('click', () => {
    rows = rowPage.value;
    DisplayList(photoArray, gallery, rows, current_page);
    SetupPagination(photoArray, pageNumber, rows);
})
```

## How to improve performance or efficiency of the MVC site, API or any other aspects.
To improve the performance of the site we can use lazyload to load large numbers of images (over 100) and use a framework to create components of each object, so that we can display, update and reload (just the component instead of the site) easily.

As for the API, we can separate the images by albums because all the images were in an array, with this, we can call small amounts of images instead of calling them all in the same request.

## Web-user favourite images.
We can implement 2 solutions:

**Client-side storage:**
Cookies were the first implementations of client-side storage. But now we can use 2 other options, LocalStorage and IndexedDB.

In this case, we can use it to store in the browser a list of favorite images marked with a star. 
When the user clicks on the image star, the image information will be saved in LocalStorage or IndexedDB (id, albumId, title, url and thumbnailsUrl), this information will be saved in a new object, so, when the user comes back to the site, the saved data will be shown as the others.
_Advantage: Easy implementation._
_Disadvantage: If the user deletes the data from the browser or wants to access the site from another browser or device, the information will be non-existent._

**Databases:**
This would be the best implementation. Following the same logic, when the user clicks on the image star, the image data (id, albumId, title, url and thumbnailsUrl) will be saved but in a database. The big difference will be that we will have to create accounts for the users.

_Advantage: The user will be able to go back to the web and see his favorite images anywhere, only when he creates an account and logs in._
_Disadvantage: Implementation would take more time._
