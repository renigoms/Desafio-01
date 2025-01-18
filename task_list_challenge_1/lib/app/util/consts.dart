import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/widgets/listtile_config.dart';

const popupMenuEntryList = <PopupMenuEntry>[
                  PopupMenuItem(
                    value: "Completed",
                    child: ListTileConfig(
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      text: "Completed",
                    ),
                  ),
                  PopupMenuItem(
                    value: "Pending",
                    child:ListTileConfig(
                      icon: Icon(
                        Icons.warning_amber,
                        color: Colors.amber,
                      ),
                      text: "Pending",
                    ),
                  ),
                  PopupMenuItem(
                    value: "WithoutFilter",
                    child: ListTileConfig(
                      icon: Icon(
                        Icons.filter_alt_off_outlined,
                        color: Colors.redAccent,
                      ),
                      text: "Without Filter",
                    ),
                  ),
                ];