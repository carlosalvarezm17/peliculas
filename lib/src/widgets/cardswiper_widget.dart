import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> listado;
  
  CardSwiper({ @required this.listado });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      
      child: Swiper(
          itemBuilder: (BuildContext context,int index){

            listado[index].uniqueId = '${listado[index].id}-tarjeta';

            return Hero(
              tag: listado[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(
                    image: NetworkImage(listado[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  onTap: () => Navigator.pushNamed(context, 'detalle', arguments: listado[index]),
                )
                //Image.network("http://via.placeholder.com/350x150", fit: BoxFit.cover,),
              ),
            );
          },
          itemCount: listado.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          //pagination: SwiperPagination(),
          //control: SwiperControl(),
          layout: SwiperLayout.STACK,
      ),
    );
  }
}