import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';

class HelperFunctions {
  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(
          child: CircularProgressIndicator(
        color: kPrimaryColor,
      ));
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(
        child: Text('No Data found'),
      );
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(
        child: Text('Something went wrong'),
      );
    }

    return null;
  }
}
