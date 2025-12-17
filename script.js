// Плавная прокрутка к секциям
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.header__nav-link');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                const headerHeight = document.querySelector('.header').offsetHeight;
                const targetPosition = targetSection.offsetTop - headerHeight;
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Добавляем активный класс при прокрутке
    const sections = document.querySelectorAll('section[id]');
    const header = document.querySelector('.header');
    
    function updateActiveNav() {
        const scrollPosition = window.scrollY + header.offsetHeight + 100;
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                navLinks.forEach(link => {
                    link.classList.remove('header__nav-link--active');
                    if (link.getAttribute('href') === `#${sectionId}`) {
                        link.classList.add('header__nav-link--active');
                    }
                });
            }
        });
    }
    
    window.addEventListener('scroll', updateActiveNav);
    updateActiveNav();
    
    // Изменение header при прокрутке
    function updateHeader() {
        const header = document.querySelector('.header');
        if (window.scrollY > 50) {
            header.classList.add('header--scrolled');
        } else {
            header.classList.remove('header--scrolled');
        }
    }
    
    window.addEventListener('scroll', updateHeader);
    updateHeader();
    
    // Анимация появления элементов при прокрутке
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);
    
    // Наблюдаем за элементами для анимации
    const animateElements = document.querySelectorAll('.problem__card, .decision__card, .people__card, .places__card, .why-coffeeok__card, .community__avatars, .join__content');
    animateElements.forEach(el => {
        observer.observe(el);
    });
});

