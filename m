From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: CONFIG_ACPI_DEBUG cost
Date: 29 Oct 2004 02:03:23 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1099029802.143.226.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The static size of the built-in part of ACPI nearly doubles with
CONFIG_ACPI_DEBUG=y.

Thinking we should have a less heavyweight DEBUG build option for use by
production kernels -- any volunteers to look into it?

thanks,
-Len


ftp://ftp.firstfloor.org/pub/ak/perl/bloat-o-meter

lenb@d845pe lenb $ size bk/26-latest-test/drivers/acpi/built-in.o
src/26-latest-dev/drivers/acpi/built-in.o
   text    data     bss     dec     hex filename
 144533    5608    4920  155061   25db5
bk/26-latest-test/drivers/acpi/built-in.o
 282285    6636    5112  294033   47c91
src/26-latest-dev/drivers/acpi/built-in.o

lenb@d845pe lenb $ ~/bin/bloat-o-meter
bk/26-latest-test/drivers/acpi/built-in.o
src/26-latest-dev/drivers/acpi/built-in.o
Symbol                         Old size  New size  Delta     Change (%)
acpi_device_get_debug_info      109831   193364   83533   +76.06
acpi_os_get_line                  2995     4184    1189   +39.70
__initcall_acpi_debug_init       (new)       28      28
__initcall_acpi_scan_init           28       32       4   +14.29
acpi_ns_convert_entry_to_handl   58374   103817   45443   +77.85
acpi_os_writable                  3038     4227    1189   +39.14
acpi_ut_init_stack_ptr_trace     (new)   149152  149152
acpi_os_wait_events_complete      2549     2781     232    +9.10
acpi_ns_valid_path_separator     57287   102116   44829   +78.25
acpi_ns_valid_root_prefix        57276   102105   44829   +78.27
acpi_ps_get_parent_scope         67052   118436   51384   +76.63
acpi_ut_valid_object_type        90856   162728   71872   +79.11
acpi_subsystem_status            87806   157720   69914   +79.62
acpi_irq_isa                      3886     4508     622   +16.01
acpi_irq_pci                      3900     4522     622   +15.95
acpi_ps_get_opcode_size          62896   112996   50100   +79.66
acpi_ps_get_opcode_name          67043   118420   51377   +76.63
acpi_irq_balance_set              3930     4552     622   +15.83
acpi_irq_nobalance_set            3914     4536     622   +15.89
acpi_ns_get_next_valid_node      58669   104625   45956   +78.33
acpi_penalize_isa_irq           102617   180847   78230   +76.23
acpi_ps_get_name                 67614   119444   51830   +76.66
acpi_bus_get_perf_flags         108254   191157   82903   +76.58
acpi_ps_set_name                 67630   119460   51830   +76.64
acpi_tb_delete_all_tables        80739   143092   62353   +77.23
acpi_device_unregister          107361   190089   82728   +77.06
acpi_ps_delete_completed_op      66814   118043   51229   +76.67
acpi_ds_initialize_region         6788    11916    5128   +75.55
acpi_os_signal                    3070     4259    1189   +38.73
acpi_ut_create_generic_state     86920   155600   68680   +79.02
acpi_ex_out_integer              (new)    79444   79444
acpi_ex_out_pointer              (new)    79422   79422
acpi_ex_out_string               (new)    79400   79400
acpi_ps_is_prefix_char           67592   119422   51830   +76.68
acpi_ut_get_event_name           90679   162529   71850   +79.24
acpi_ut_get_mutex_name           (new)   162706  162706
acpi_ut_get_type_name            90701   162551   71850   +79.22
acpi_release_global_lock         22894    41777   18883   +82.48
acpi_ps_init_op                  67410   119106   51696   +76.69
acpi_ps_is_leading_char          67567   119397   51830   +76.71
acpi_os_get_thread_id             3044     4233    1189   +39.06
acpi_ps_create_scope_op          67384   119080   51696   +76.72
acpi_ut_get_object_type_name     90723   162573   71850   +79.20
acpi_ec_space_setup              98874   174280   75406   +76.26
acpi_ps_peek_opcode              62910   113010   50100   +79.64
acpi_ut_report_error             87414   156670   69256   +79.23
acpi_ut_report_info              87472   156728   69256   +79.18
acpi_ut_report_warning           87443   156699   69256   +79.20
acpi_hw_clear_gpe                47688    85233   37545   +78.73
acpi_ut_generate_checksum        87310   156566   69256   +79.32
acpi_ns_get_parent_node          58645   104594   45949   +78.35
acpi_power_open_fs              105928   187368   81440   +76.88
acpi_system_alarm_open_fs        94594   167971   73377   +77.57
acpi_system_sleep_open_fs        93977   167313   73336   +78.04
acpi_system_wakeup_device_open   96234   169733   73499   +76.38
acpi_ex_link_mutex               45502    81298   35796   +78.67
acpi_ps_has_completed_scope      67063   118447   51384   +76.62
acpi_system_close_event         107019   189155   82136   +76.75
acpi_device_release             107116   189844   82728   +77.23
acpi_ev_is_notify_object         19448    36112   16664   +85.68
acpi_ut_get_region_name          90644   162494   71850   +79.27
acpi_ut_hex_to_ascii_char        90609   162459   71850   +79.30
acpi_install_initialization_ha   87964   157976   70012   +79.59
acpi_ex_system_do_suspend        38999    67734   28735   +73.68
acpi_tb_init_generic_address     75716   135203   59487   +78.57
acpi_ut_get_descriptor_name      90819   162669   71850   +79.11
acpi_motherboard_add            110789   194722   83933   +75.76
acpi_ut_copy_id_string           84303   150965   66662   +79.07
acpi_ut_track_stack_ptr          (new)   149161  149161
acpi_motherboard_init             4999     6475    1476   +29.53
acpi_ns_map_handle_to_node       58339   103778   45439   +77.89
acpi_tb_get_table_count          75516   134992   59476   +78.76
acpi_ut_exit                     (new)   149586  149586
acpi_os_readable                  2998     4187    1189   +39.66
acpi_hw_write_gpe_enable_reg     47652    85192   37540   +78.78
acpi_ex_out_address              (new)    79466   79466
acpi_ex_truncate_for32bit_tabl   45035    77529   32494   +72.15
acpi_ex_unlink_mutex             45460    81256   35796   +78.74
acpi_rs_get_resource_type        70944   124676   53732   +75.74
acpi_ut_debug_print_raw          (new)   149356  149356
acpi_ut_get_object_size          92792   165940   73148   +78.83
acpi_ut_ptr_exit                 (new)   149773  149773
acpi_ut_trace                    (new)   149398  149398
acpi_ut_strupr                   86342   154072   67730   +78.44
acpi_ut_dword_byte_swap          85710   153146   67436   +78.68
acpi_ut_fadt_register_error      84948   152144   67196   +79.10
acpi_bus_match                  108271   191174   82903   +76.57
acpi_poweroff_init               92880   166036   73156   +78.76
acpi_tb_checksum                 81277   144073   62796   +77.26
acpi_ut_trace_ptr                (new)   149442  149442
acpi_ut_trace_str                (new)   149490  149490
acpi_ut_trace_u32                (new)   149538  149538
acpi_ut_valid_acpi_character     85857   153465   67608   +78.74
try_get_root_bridge_busnr       100334   176630   76296   +76.04
acpi_ec_gpe_handler              98825   174231   75406   +76.30
acpi_ns_get_attached_data        60557   109702   49145   +81.15
acpi_ns_dump_entry               (new)   107255  107255
acpi_ns_get_pathname_length      56804   101472   44668   +78.64
acpi_rs_dump_fixed_io            (new)   129629  129629
acpi_bus_data_handler           107380   190108   82728   +77.04
acpi_pci_data_handler           103864   183104   79240   +76.29
acpi_ut_set_integer_width        85750   153193   67443   +78.65
acpi_power_off                   92828   165984   73156   +78.81
ec_write                         98356   173592   75236   +76.49
acpi_hw_clear_gpe_block          47863    85420   37557   +78.47
acpi_hw_disable_gpe_block        47810    85367   37557   +78.55
acpi_ut_find_allocation          (new)   148003  148003
acpi_ex_system_reset_event       39185    68269   29084   +74.22
acpi_ut_create_pkg_state_and_p   86838   155388   68550   +78.94
acpi_suspend                     93235   166391   73156   +78.46
acpi_ex_register_overflow        32462    57694   25232   +77.73
acpi_ut_dump_allocation_info     (new)   148700  148700
acpi_ut_validate_buffer          83091   146946   63855   +76.85
acpi_system_open_event          106748   188776   82028   +76.84
ec_read                          98298   173534   75236   +76.54
acpi_device_set_context         109772   193305   83533   +76.10
acpi_ns_remove_reference         55913    99434   43521   +77.84
acpi_tb_get_rsdt_address         78371   138912   60541   +77.25
acpi_ev_cmos_region_setup        20914    38559   17645   +84.37
acpi_ev_pci_bar_region_setup     20911    38498   17587   +84.10
acpi_ex_cmos_space_handler       44224    75300   31076   +70.27
acpi_ex_pci_bar_space_handler    44227    75361   31134   +70.40
acpi_ut_create_update_state_an   86786   155327   68541   +78.98
acpi_ut_valid_acpi_name          85801   153404   67603   +78.79
acpi_ev_global_lock_thread       19776    36594   16818   +85.04
acpi_hw_enable_runtime_gpe_blo   47916    85473   37557   +78.38
acpi_hw_enable_wakeup_gpe_bloc   47979    85536   37557   +78.28
acpi_ut_value_exit               (new)   149710  149710
acpi_ds_delete_walk_state_cach   15937    28945   13008   +81.62
acpi_system_poll_event          107052   189188   82136   +76.73
acpi_ut_delete_generic_cache     83047   146882   63835   +76.87
acpi_ut_delete_generic_state_c   87090   156143   69053   +79.29
acpi_ut_delete_object_cache      92503   165364   72861   +78.77
acpi_ec_io_ports                 99782   175787   76005   +76.17
acpi_ev_fixed_event_initialize   16367    30018   13651   +83.41
acpi_ev_valid_gpe_event          24480    44468   19988   +81.65
acpi_ns_dump_objects             (new)   107027  107027
acpi_rs_dump_vendor_specific     (new)   129679  129679
acpi_ut_delete_generic_state     87076   156075   68999   +79.24
get_root_bridge_busnr_callback  100266   176562   76296   +76.09
acpi_ns_detach_data              60488   109633   49145   +81.25
acpi_pm_finish                   93166   166322   73156   +78.52
acpi_ut_get_node_name            90750   162600   71850   +79.17
acpi_pci_unregister_driver      100196   176492   76296   +76.15
acpi_tb_delete_single_table      80893   143323   62430   +77.18
acpi_ps_delete_parse_cache       67550   119326   51776   +76.65
acpi_pci_register_driver        100124   176420   76296   +76.20
acpi_ps_get_arg                  66080   117116   51036   +77.23
acpi_ut_translate_one_cid        84427   151172   66745   +79.06
acpi_ev_gpe_xrupt_handler        18320    33449   15129   +82.58
acpi_acquire_global_lock         22820    41703   18883   +82.75
acpi_ds_get_current_walk_state   15384    27864   12480   +81.12
acpi_ex_release_all_mutexes      46122    82249   36127   +78.33
acpi_ut_get_resource_end_tag     87340   156596   69256   +79.29
acpi_ex_system_do_stall          38930    67659   28729   +73.80
acpi_hw_get_bit_register_info    48574    86623   38049   +78.33
acpi_ut_push_generic_state       86886   155443   68557   +78.90
acpi_ev_sci_xrupt_handler        18296    33372   15076   +82.40
acpi_rs_dump_fixed_memory32      (new)   129957  129957
acpi_hw_enable_all_runtime_gpe   48074    85689   37615   +78.24
acpi_hw_enable_all_wakeup_gpes   48091    85767   37676   +78.34
acpi_ut_get_element_length       92634   165704   73070   +78.88
acpi_terminate                   87791   157641   69850   +79.56
acpi_ps_get_next_package_end     61592   111146   49554   +80.46
acpi_ds_push_walk_state          15398    27938   12540   +81.44
acpi_purge_cached_objects        88000   158012   70012   +79.56
acpi_ut_pop_generic_state        86902   155519   68617   +78.96
acpi_ev_reg_run                  18213    33287   15074   +82.77
acpi_ns_get_next_node            60608   109752   49144   +81.09
acpi_rs_end_depend_fns_stream    72234   126650   54416   +75.33
acpi_ev_remove_sci_handler       18361    33612   15251   +83.06
acpi_ut_status_exit              (new)   149625  149625
acpi_ds_pop_walk_state           15419    28019   12600   +81.72
acpi_pm_prepare                  92928   166084   73156   +78.72
acpi_rs_end_tag_stream           71790   125796   54006   +75.23
get_date_field                   94625   168002   73377   +77.55
acpi_detach_data                 55275    98262   42987   +77.77
acpi_ut_mutex_terminate          86416   154243   67827   +78.49
acpi_ev_install_sci_handler      18331    33522   15191   +82.87
acpi_ex_system_signal_event      39132    68082   28950   +73.98
acpi_hw_disable_all_gpes         48042    85599   37557   +78.18
acpi_irq_penalty_update           3795     4417     622   +16.39
acpi_ev_default_region_setup     20917    38620   17703   +84.63
acpi_ev_io_space_region_setup    20404    37768   17364   +85.10
acpi_ps_free_op                  67524   119234   51710   +76.58
acpi_os_delete_lock               2582     2900     318   +12.32
acpi_set_firmware_waking_vecto   49864    88852   38988   +78.19
acpi_get_type                    60944   110240   49296   +80.89
acpi_rs_end_tag_resource         71748   125700   53952   +75.20
acpi_ex_system_wait_event        39155    68172   29017   +74.11
acpi_ut_allocate_and_track       (new)   147549  147549
acpi_attach_data                 55176    98163   42987   +77.91
acpi_get_data                    55364    98351   42987   +77.64
irqrouter_resume                102524   180605   78081   +76.16
acpi_ut_create_control_state     87051   155974   68923   +79.18
acpi_ev_init_global_lock_handl   19963    36783   16820   +84.26
acpi_ex_exit_interpreter         44989    77427   32438   +72.10
acpi_rs_end_depend_fns_resourc   72128   126418   54290   +75.27
acpi_ds_result_stack_push        15033    26916   11883   +79.05
acpi_ex_enter_interpreter        44940    77324   32384   +72.06
acpi_ps_alloc_op                 67426   119131   51705   +76.68
acpi_ut_create_thread_state      86936   155621   68685   +79.01
acpi_ds_scope_stack_clear         9376    16444    7068   +75.38
acpi_hw_get_gpe_status           47711    85263   37552   +78.71
acpi_ev_execute_reg_methods      18173    33182   15009   +82.59
acpi_ev_notify_dispatch          19676    36489   16813   +85.45
acpi_ex_unsigned_integer_to_st   45365    78116   32751   +72.19
acpi_ns_attach_data              60384   109528   49144   +81.39
acpi_rs_dump_io                  (new)   129524  129524
acpi_rs_dump_memory24            (new)   129747  129747
acpi_rs_dump_memory32            (new)   129852  129852
acpi_ns_report_method_error      57070   101886   44816   +78.53
acpi_ps_cleanup_scope            67347   118974   51627   +76.66
acpi_tb_handle_to_object         81020   143560   62540   +77.19
acpi_rs_fixed_io_stream          70596   124121   53525   +75.82
acpi_ex_do_match                 29216    52436   23220   +79.48
acpi_ut_delete_internal_object   89685   160793   71108   +79.29
acpi_os_create_lock               2559     2791     232    +9.07
acpi_ev_fixed_event_dispatch     16524    30235   13711   +82.98
acpi_get_parent                  61040   110336   49296   +80.76
acpi_ds_clear_operands           12169    21839    9670   +79.46
acpi_get_timer_resolution        51508    91212   39704   +77.08
acpi_ev_get_gpe_event_info       23589    43209   19620   +83.17
acpi_get_timer                   51549    91324   39775   +77.16
acpi_ns_print_node_pathname      57176   101992   44816   +78.38
acpi_ds_obj_stack_delete_all     15115    27157   12042   +79.67
acpi_ns_dump_root_devices        (new)    93944   93944
acpi_ns_get_secondary_object     60354   109411   49057   +81.28
acpi_ps_get_depth_next           66439   117483   51044   +76.83
acpi_sleep_proc_init             96265   169764   73499   +76.35
acpi_ut_valid_internal_object    92415   164963   72548   +78.50
acpi_ns_create_node              55464    98452   42988   +77.51
acpi_ns_dump_pathname            (new)   105617  105617
acpi_ut_create_update_state      86965   155724   68759   +79.07
acpi_ds_resolve_operands         12117    21720    9603   +79.25
acpi_ex_check_object_type        38028    65592   27564   +72.48
acpi_pci_root_remove            100902   177454   76552   +75.87
acpi_ec_remove_fs                99360   175093   75733   +76.22
acpi_power_remove_fs            106066   187639   81573   +76.91
acpi_ps_get_opcode_info          66984   118300   51316   +76.61
acpi_ut_copy_iobject_to_eobjec   88467   158698   70231   +79.39
acpi_match_ids                  107695   190510   82815   +76.90
acpi_rs_fixed_io_resource        70468   123867   53399   +75.78
acpi_ds_init_callbacks           12700    22936   10236   +80.60
acpi_ec_remove                   99744   175664   75920   +76.11
acpi_ex_release_global_lock      45102    77704   32602   +72.29
acpi_ns_get_internal_name_leng   57406   102411   45005   +78.40
acpi_pci_root_init                3643     4107     464   +12.74
acpi_clear_event                 18896    35045   16149   +85.46
acpi_rs_fixed_memory32_stream    75031   134052   59021   +78.66
acpi_install_exception_handler   21248    39264   18016   +84.79
acpi_system_sleep_seq_show       93892   167188   73296   +78.06
acpi_ut_add_reference            90408   161993   71585   +79.18
acpi_ut_mutex_initialize         86383   154118   67735   +78.41
acpi_ev_global_lock_handler      19837    36656   16819   +84.79
acpi_ns_parse_table              61416   110824   49408   +80.45
acpi_power_remove               106429   188158   81729   +76.79
acpi_ps_append_arg               66147   117188   51041   +77.16
acpi_ex_eisa_id_to_string        45242    77988   32746   +72.38
acpi_get_firmware_waking_vecto   49899    88946   39047   +78.25
acpi_ut_callocate_and_track      (new)   147646  147646
acpi_ut_delete_object_desc       92483   165235   72752   +78.67
acpi_ex_data_table_space_handl   44230    75422   31192   +70.52
acpi_hw_initialize               47312    84436   37124   +78.47
acpi_os_acquire_lock              2587     2994     407   +15.73
acpi_os_release_lock              2604     3124     520   +19.97
acpi_rs_get_prt_method_data      75092   134176   59084   +78.68
acpi_rs_start_depend_fns_strea   72170   126520   54350   +75.31
acpi_ut_copy_eobject_to_iobjec   88723   159149   70426   +79.38
acpi_os_delete_semaphore          2697     3435     738   +27.36
acpi_rs_io_stream                70528   123989   53461   +75.80
acpi_ut_create_pkg_state         87001   155842   68841   +79.13
acpi_ex_acquire_global_lock      45070    77571   32501   +72.11
acpi_ns_print_pathname           (new)   105484  105484
acpi_pci_link_resume            102491   180472   77981   +76.09
acpi_rs_fixed_memory32_resourc   74882   133779   58897   +78.65
acpi_system_write_sleep          94008   167344   73336   +78.01
acpi_ut_copy_ielement_to_eelem   88253   158414   70161   +79.50
acpi_ns_get_type                 57298   102127   44829   +78.24
acpi_rs_dump_irq_list            (new)   132071  132071
acpi_get_irq_routing_table       72256   126736   54480   +75.40
acpi_ps_init_scope               67096   118480   51384   +76.58
irqrouter_init_sysfs              3946     4568     622   +15.76
acpi_power_seq_show             105837   187232   81395   +76.91
acpi_rs_dump_start_depend_fns    (new)   129388  129388
acpi_tb_verify_table_checksum    81200   143937   62737   +77.26
acpi_ds_result_stack_pop         15073    27019   11946   +79.25
acpi_ex_unload_table             27593    49571   21978   +79.65
acpi_get_next_object             61151   110447   49296   +80.61
acpi_ns_unload_namespace         53641    95196   41555   +77.47
acpi_rs_get_method_data          75278   134584   59306   +78.78
acpi_rs_get_crs_method_data      75154   134306   59152   +78.71
acpi_rs_get_prs_method_data      75216   134445   59229   +78.75
acpi_rs_memory32_range_stream    74955   133912   58957   +78.66
acpi_unload_table                79137   140203   61066   +77.16
acpi_ut_initialize_buffer        83148   147003   63855   +76.80
acpi_bus_unregister_driver      108802   192137   83335   +76.59
acpi_ds_obj_stack_get_value      15341    27723   12382   +80.71
acpi_ds_obj_stack_pop            15205    27415   12210   +80.30
acpi_ev_walk_gpe_list            24543    44536   19993   +81.46
acpi_ut_evaluate_numeric_objec   84246   150824   66578   +79.03
acpi_ev_initialize_op_regions    16720    30512   13792   +82.49
acpi_ns_terminate                58379   103822   45443   +77.84
acpi_pci_link_remove            102560   180705   78145   +76.19
acpi_ds_method_data_delete_val    5900    10037    4137   +70.12
acpi_rs_io_resource              70384   123724   53340   +75.78
acpi_set_current_resources       72626   127492   54866   +75.55
acpi_ut_remove_reference         90436   162118   71682   +79.26
acpi_ds_obj_stack_push           15163    27271   12108   +79.85
acpi_ns_build_external_path      56724   101160   44436   +78.34
acpi_set_gpe_type                18589    34347   15758   +84.77
acpi_ut_delete_mutex             86520   154489   67969   +78.56
acpi_ex_system_release_mutex     39092    67937   28845   +73.79
acpi_rs_memory32_range_resourc   74797   133634   58837   +78.66
acpi_rs_vendor_stream            71936   126066   54130   +75.25
acpi_get_event_status            19013    35320   16307   +85.77
acpi_rs_memory24_resource        74624   133340   58716   +78.68
acpi_get_current_resources       72304   126871   54567   +75.47
acpi_get_possible_resources      72352   127018   54666   +75.56
acpi_rs_memory24_stream          74713   133486   58773   +78.67
acpi_ds_method_data_init          5328     8488    3160   +59.31
acpi_ec_wait                     97700   172684   74984   +76.75
acpi_ev_fixed_event_detect       16435    30086   13651   +83.06
acpi_ns_local                    57344   102261   44917   +78.33
acpi_clear_gpe                   18934    35169   16235   +85.75
acpi_disable_gpe                 18733    34645   15912   +84.94
acpi_pm_enter                    93015   166171   73156   +78.65
acpi_ut_copy_ipackage_to_epack   88374   158547   70173   +79.40
acpi_ut_release_to_cache         82756   146504   63748   +77.03
acpi_ev_set_gpe_type             23184    42380   19196   +82.80
acpi_pci_link_init                3994     4703     709   +17.75
acpi_enable_gpe                  18651    34491   15840   +84.93
acpi_ex_create_event             39342    68490   29148   +74.09
acpi_ex_get_buffer_datum         33179    58935   25756   +77.63
acpi_ex_set_buffer_datum         33265    59089   25824   +77.63
acpi_get_name                    58908   104869   45961   +78.02
acpi_hw_get_mode                 47594    85034   37440   +78.67
acpi_ut_allocate_object_desc_d   92434   165080   72646   +78.59
acpi_get_gpe_status              19058    35466   16408   +86.10
acpi_ps_get_next_namestring      61612   111226   49614   +80.53
acpi_ut_create_mutex             86446   154332   67886   +78.53
acpi_ut_debug_print              (new)   149199  149199
acpi_enable_wakeup_device_prep   93292   166448   73156   +78.42
acpi_ev_delete_gpe_handlers      24629    44677   20048   +81.40
acpi_system_read_info           106476   188288   81812   +76.84
acpi_ut_get_package_object_siz   92712   165782   73070   +78.81
acpi_bus_get_device              96384   169884   73500   +76.26
acpi_system_read_dsdt           106570   188446   81876   +76.83
acpi_ut_subsystem_shutdown       85438   152750   67312   +78.78
acpi_device_get_busid           109231   192763   83532   +76.47
acpi_ns_dump_tables              (new)   107095  107095
acpi_ut_display_init_pathname    (new)   153244  153244
acpi_ex_digits_needed            45165    77827   32662   +72.32
acpi_ns_delete_namespace_subtr   55820    99273   43453   +77.84
acpi_ns_get_attached_object      60317   109250   48933   +81.13
acpi_bus_check_scope             97592   172192   74600   +76.44
acpi_ex_dump_operands            (new)    79238   79238
acpi_ns_opens_scope              58424   103964   45540   +77.95
acpi_ns_report_error             56920   101724   44804   +78.71
acpi_rs_dump_irq                 (new)   129000  129000
acpi_ut_copy_iobject_to_iobjec   89360   160002   70642   +79.05
acpi_ds_method_data_get_type      5712     9508    3796   +66.46
acpi_ev_install_region_handler   16632    30348   13716   +82.47
acpi_event_init                   4355     5378    1023   +23.49
acpi_find_root_pointer           82295   145504   63209   +76.81
acpi_ex_create_alias             39236    68324   29088   +74.14
acpi_ex_system_acquire_mutex     39031    67771   28740   +73.63
acpi_rs_dma_stream               70841   124510   53669   +75.76
acpi_ds_obj_stack_pop_and_dele   15261    27556   12295   +80.56
acpi_tb_uninstall_table          80949   143393   62444   +77.14
acpi_ex_opcode_1A_1T_0R          34859    61305   26446   +75.87
acpi_ns_get_external_pathname    (new)   101304  101304
acpi_ps_get_child                66268   117315   51047   +77.03
acpi_system_read_fadt           106658   188605   81947   +76.83
acpi_ns_delete_node              55510    98570   43060   +77.57
acpi_tb_get_table_body           77465   137395   59930   +77.36
acpi_ut_execute_HID              84341   151003   66662   +79.04
acpi_pci_irq_find_prt_entry     102636   180864   78228   +76.22
acpi_ut_execute_UID              84713   151567   66854   +78.92
acpi_ns_detach_object            60252   109079   48827   +81.04
acpi_tb_recognize_table          80420   142577   62157   +77.29
acpi_tb_convert_to_xsdt          75550   135031   59481   +78.73
acpi_ds_begin_method_execution    9827    17694    7867   +80.05
acpi_ev_attach_region            17462    32125   14663   +83.97
acpi_power_get_context          104612   184664   80052   +76.52
acpi_ds_delete_result_if_not_u   12053    21545    9492   +78.75
acpi_pci_link_check_current     101175   178114   76939   +76.05
acpi_tb_get_table                77172   136896   59724   +77.39
acpi_ev_system_memory_region_s   20312    37592   17280   +85.07
acpi_os_signal_semaphore          2940     4008    1068   +36.33
acpi_ps_push_scope               67158   118615   51457   +76.62
acpi_bus_scan_fixed             110563   194305   83742   +75.74
acpi_get_devices                 55082    97986   42904   +77.89
acpi_ut_allocate                 83287   147143   63856   +76.67
acpi_ex_create_power_resource    40083    69681   29598   +73.84
acpi_ds_get_buffer_field_argum    6526    11126    4600   +70.49
acpi_ec_stop                    100045   176237   76192   +76.16
acpi_os_create_semaphore          2622     3254     632   +24.10
acpi_ds_method_data_set_value     5658     9326    3668   +64.83
acpi_system_wakeup_device_seq_   95827   169326   73499   +76.70
acpi_walk_namespace              54655    97435   42780   +78.27
acpi_bus_register_driver        108720   191954   83234   +76.56
acpi_ex_system_wait_semaphore    38856    67476   28620   +73.66
acpi_ps_pop_scope                67247   118791   51544   +76.65
acpi_rs_vendor_resource          71815   125883   54068   +75.29
acpi_ns_dump_one_device          (new)    93760   93760
acpi_scan_init                    4415     5809    1394   +31.57
acpi_ut_terminate                85368   152565   67197   +78.71
acpi_bus_find_driver            108878   192278   83400   +76.60
acpi_irq_penalty_init             3672     4230     558   +15.20
acpi_ex_create_mutex             39437    68644   29207   +74.06
acpi_ex_create_processor         39974    69493   29519   +73.85
acpi_ns_get_object_value         56644   100970   44326   +78.25
acpi_ds_exec_begin_control_op     7702    13585    5883   +76.38
acpi_ns_load_namespace           53471    94793   41322   +77.28
acpi_ut_execute_STA              84800   151737   66937   +78.94
acpi_ds_create_walk_state        15442    28105   12663   +82.00
acpi_driver_detach              108594   191762   83168   +76.59
acpi_ps_get_next_package_lengt   61456   110952   49496   +80.54
acpi_ds_method_data_delete_all    5425     8637    3212   +59.21
acpi_ev_install_gpe_block        25300    45959   20659   +81.66
acpi_format_exception            90476   162264   71788   +79.34
acpi_pci_link_get_possible      101129   177919   76790   +75.93
acpi_ev_install_xrupt_handlers   16257    29822   13565   +83.44
acpi_ds_create_node              11290    20213    8923   +79.03
acpi_resource_to_address64       72675   127635   54960   +75.62
acpi_enable                      18384    33696   15312   +83.29
acpi_ex_do_logical_numeric_op    41521    71620   30099   +72.49
acpi_ex_system_io_space_handle   44056    74888   30832   +69.98
acpi_ds_get_buffer_arguments      6574    11306    4732   +71.98
acpi_ds_get_package_arguments     6650    11507    4857   +73.04
acpi_ns_handle_to_pathname       56849   101522   44673   +78.58
acpi_ut_short_divide             91572   163656   72084   +78.72
acpi_install_address_space_han   22920    41804   18884   +82.39
acpi_remove_gpe_block            19343    35907   16564   +85.63
acpi_rs_irq_stream               74048   132548   58500   +79.00
acpi_disable                     18458    33895   15437   +83.63
acpi_ut_create_internal_object   92064   164324   72260   +78.49
acpi_ex_decode_field_access      37384    64356   26972   +72.15
acpi_ec_init                      3557     3901     344    +9.67
acpi_rs_start_depend_fns_resou   72017   126211   54194   +75.25
acpi_ds_get_region_arguments      6726    11708    4982   +74.07
acpi_ec_add_fs                   99262   174884   75622   +76.18
acpi_ex_common_buffer_setup      33340    59243   25903   +77.69
acpi_device_register            107151   189879   82728   +77.21
acpi_ds_result_insert            14664    25760   11096   +75.67
acpi_ut_create_string_object     92299   164753   72454   +78.50
acpi_ut_osi_implementation       83856   150172   66316   +79.08
acpi_ns_find_parent_name         58613   104383   45770   +78.09
acpi_power_get_state            104668   184838   80170   +76.59
acpi_ds_result_pop               14775    26228   11453   +77.52
acpi_ev_release_global_lock      20113    37156   17043   +84.74
acpi_ex_pci_config_space_handl   44134    75087   30953   +70.13
acpi_tb_delete_tables_by_type    80757   143110   62353   +77.21
acpi_ev_disable_gpe              23486    42995   19509   +83.07
acpi_ns_delete_subtree           53516    94982   41466   +77.48
acpi_ut_allocate_owner_id        90867   162739   71872   +79.10
acpi_ds_create_field              4621     7416    2795   +60.48
acpi_ex_opcode_0A_0T_1R          34576    60860   26284   +76.02
acpi_ut_copy_ipackage_to_ipack   89220   159787   70567   +79.09
acpi_ex_opcode_2A_0T_0R          42100    72344   30244   +71.84
acpi_ut_execute_sxds             84867   151926   67059   +79.02
acpi_power_init                   4053     4856     803   +19.81
acpi_ev_initialize_events        16148    29604   13456   +83.33
acpi_ex_dump_node                (new)    79508   79508
acpi_ex_resolve_to_value         29728    53064   23336   +78.50
acpi_ns_delete_namespace_by_ow   55967    99493   43526   +77.77
acpi_hw_low_level_write          49775    88632   38857   +78.07
acpi_ev_delete_gpe_xrupt         25189    45739   20550   +81.58
acpi_ds_create_operands          12637    22714   10077   +79.74
acpi_tb_match_signature          80188   142108   61920   +77.22
acpi_bus_init                     2850     3018     168    +5.89
acpi_ev_terminate                20235    37369   17134   +84.68
acpi_ex_allocate_name_string     28536    51180   22644   +79.35
acpi_get_handle                  58688   104644   45956   +78.31
acpi_rs_dump_dma                 (new)   129163  129163
acpi_system_write_wakeup_devic   96009   169508   73499   +76.55
acpi_tb_get_primary_table        79476   140900   61424   +77.29
acpi_ut_create_buffer_object     92172   164528   72356   +78.50
acpi_ds_method_data_init_args     5497     8832    3335   +60.67
acpi_ev_update_gpe_enable_mask   23251    42533   19282   +82.93
acpi_hw_low_level_read           49680    88406   38726   +77.95
acpi_rs_dump_extended_irq        (new)   131567  131567
acpi_ds_restart_control_method   10328    18544    8216   +79.55
acpi_get_timer_duration          51585    91437   39852   +77.26
acpi_ut_acquire_from_cache       82889   146655   63766   +76.93
acpi_remove_fixed_event_handle   21416    39657   18241   +85.17
acpi_tb_scan_memory_for_rsdp     82357   145669   63312   +76.88
acpi_ut_free_and_track           (new)   147775  147775
acpi_ut_callocate                83377   147320   63943   +76.69
acpi_ex_opcode_1A_0T_0R          34715    61075   26360   +75.93
acpi_init                         2987     3241     254    +8.50
acpi_ut_copy_simple_object       88750   159280   70530   +79.47
acpi_ec_read_info                99098   174652   75554   +76.24
acpi_ds_result_push              14938    26683   11745   +78.62
acpi_rs_get_pci_routing_table_   73631   128764   55133   +74.88
acpi_power_get_inferred_state   105534   186659   81125   +76.87
acpi_ut_print_string             85476   152912   67436   +78.89
acpi_initialize_subsystem        87504   156760   69256   +79.15
acpi_system_write_debug          (new)   189608  189608
acpi_ev_enable_gpe               23369    42759   19390   +82.97
acpi_ns_install_node             55603    98739   43136   +77.58
acpi_ns_one_complete_parse       61292   110588   49296   +80.43
acpi_hw_clear_acpi_status        48108    85848   37740   +78.45
acpi_ps_delete_parse_tree        66833   118062   51229   +76.65
acpi_reserve_io_ranges          110660   194484   83824   +75.75
acpi_rs_create_resource_list     69820   122336   52516   +75.22
acpi_rs_extended_irq_stream      74458   133099   58641   +78.76
acpi_ds_delete_walk_state        15827    28706   12879   +81.37
acpi_bus_get_status              96434   170043   73609   +76.33
acpi_driver_attach              108467   191522   83055   +76.57
acpi_ev_install_handler          17503    32298   14795   +84.53
acpi_power_add_fs               105959   187399   81440   +76.86
acpi_tb_get_table_ptr            78027   138342   60315   +77.30
acpi_ds_result_pop_from_bottom   14853    26441   11588   +78.02
acpi_ex_create_method            40183    69860   29677   +73.85
acpi_get_table_header            79192   140343   61151   +77.22
acpi_get_system_info             87819   157733   69914   +79.61
acpi_ex_add_table                26596    48048   21452   +80.66
acpi_ns_initialize_devices       59551   107592   48041   +80.67
acpi_tb_install_table            80282   142330   62048   +77.29
acpi_disable_event               18812    34796   15984   +84.97
acpi_enable_event                18503    34098   15595   +84.28
acpi_ex_prep_common_field_obje   37476    64561   27085   +72.27
acpi_get_register                48593    86698   38105   +78.42
acpi_ns_internalize_name         57763   102956   45193   +78.24
acpi_initialize_objects          87730   157389   69659   +79.40
acpi_ns_execute_control_method   56572   100716   44144   +78.03
acpi_bus_get_wakeup_device_fla  108085   190900   82815   +76.62
acpi_ns_get_node_by_path         58487   104126   45639   +78.03
acpi_ds_result_remove            14717    25970   11253   +76.46
acpi_load_table                  78981   139944   60963   +77.19
acpi_rs_create_byte_stream       70309   123461   53152   +75.60
acpi_disable_wakeup_device_pow  105362   186397   81035   +76.91
acpi_tb_build_common_facs        76995   136632   59637   +77.46
acpi_enter_sleep_state_s4bios    50731    90204   39473   +77.81
acpi_ev_match_prw_and_gpe        24837    45159   20322   +81.82
acpi_ds_create_index_field        5148     8223    3075   +59.73
acpi_debug_init                  (new)     5542    5542
acpi_ps_next_parse_state         63308   113559   50251   +79.38
acpi_rs_set_srs_method_data      75339   134722   59383   +78.82
acpi_ds_method_data_get_node      5572     9058    3486   +62.56
acpi_install_fixed_event_handl   21300    39389   18089   +84.92
acpi_bus_extract_wakeup_device  107816   190631   82815   +76.81
acpi_ds_scope_stack_pop           9553    16960    7407   +77.54
acpi_ex_store_buffer_to_buffer   30532    54428   23896   +78.27
acpi_ex_resolve_object           46916    83772   36856   +78.56
acpi_ev_acquire_global_lock      20002    36885   16883   +84.41
acpi_tb_validate_rsdt            78423   138972   60549   +77.21
acpi_tb_validate_table_header    81069   143666   62597   +77.21
acpi_ex_store_string_to_string   30698    54697   23999   +78.18
acpi_ps_get_next_field           62324   112232   49908   +80.08
acpi_power_get_list_state       104738   185050   80312   +76.68
acpi_ut_copy_ielement_to_ielem   88979   159511   70532   +79.27
acpi_ut_get_simple_object_size   92512   165428   72916   +78.82
acpi_enable_wakeup_device        93404   166606   73202   +78.37
acpi_ex_opcode_3A_0T_0R          46192    82324   36132   +78.22
acpi_rs_dump_resource_list       (new)   131793  131793
acpi_os_queue_for_execution       2411     2501      90    +3.73
acpi_early_init                   2613     2737     124    +4.75
acpi_ec_query                    98408   173644   75236   +76.45
acpi_ns_evaluate_by_handle       56430   100435   44005   +77.98
acpi_ex_do_math_op               41244    71338   30094   +72.97
acpi_rs_dma_resource             70639   124228   53589   +75.86
acpi_ex_convert_to_buffer        31164    55379   24215   +77.70
acpi_enable_wakeup_device_powe  105176   186113   80937   +76.95
acpi_ev_delete_gpe_block         25415    46154   20739   +81.60
acpi_ns_initialize_objects       59508   107308   47800   +80.33
acpi_install_gpe_block           19142    35622   16480   +86.09
acpi_pci_irq_lookup             103260   181891   78631   +76.15
acpi_ds_create_bank_field         4954     7936    2982   +60.19
acpi_ds_initialize_objects       16079    29313   13234   +82.31
acpi_ex_convert_to_ascii         31326    55662   24336   +77.69
acpi_ds_build_internal_object    10632    19188    8556   +80.47
acpi_tb_table_override           77542   137564   60022   +77.41
acpi_ps_get_next_simple_arg      62083   111937   49854   +80.30
acpi_ns_delete_children          55699    98975   43276   +77.70
acpi_rs_address32_stream         68964   121249   52285   +75.81
acpi_bus_get_flags              108997   192464   83467   +76.58
acpi_bus_driver_init            108319   191222   82903   +76.54
acpi_ds_init_one_object          15948    29012   13064   +81.92
acpi_ns_evaluate_by_name         56317   100134   43817   +77.80
acpi_tb_get_secondary_table      79586   141125   61539   +77.32
acpi_disable_wakeup_device       93635   166883   73248   +78.23
acpi_ds_init_field_objects        4759     7631    2872   +60.35
acpi_system_init                  4159     5073     914   +21.98
acpi_ut_remove_allocation        (new)   148395  148395
acpi_bus_check_device            97493   171886   74393   +76.31
acpi_ec_gpe_query                98592   173925   75333   +76.41
acpi_os_get_pci_id              103865   183155   79290   +76.34
acpi_ex_concat_template          40545    70469   29924   +73.80
acpi_tb_get_table_rsdt           78585   139243   60658   +77.19
acpi_rs_address16_stream         68402   120523   52121   +76.20
acpi_evaluate_object_typed       54096    96488   42392   +78.36
acpi_get_table                   79311   140585   61274   +77.26
acpi_bus_generate_event          97046   171215   74169   +76.43
acpi_install_gpe_handler         22383    41043   18660   +83.37
acpi_pci_irq_add_entry          102734   181034   78300   +76.22
acpi_ev_get_gpe_xrupt_block      25021    45423   20402   +81.54
acpi_rs_get_byte_stream_length   72876   127836   54960   +75.42
acpi_ns_search_parent_tree       53740    95668   41928   +78.02
acpi_ut_copy_isimple_to_esimpl   88024   158096   70072   +79.61
acpi_bus_get_power               96559   170283   73724   +76.35
acpi_system_read_event          106806   188834   82028   +76.80
acpi_ut_execute_CID              84499   151244   66745   +78.99
acpi_ev_save_method_info         24710    44835   20125   +81.44
acpi_tb_get_table_header         77268   137071   59803   +77.40
acpi_ex_create_table_region      39755    69168   29413   +73.99
acpi_ev_asynch_execute_gpe_met   23951    43653   19702   +82.26
acpi_walk_resources              72400   127165   54765   +75.64
acpi_tb_verify_rsdp              78136   138584   60448   +77.36
acpi_bus_notify                  97632   172354   74722   +76.53
acpi_ev_gpe_detect               23697    43322   19625   +82.82
acpi_ut_copy_esimple_to_isimpl   88520   158818   70298   +79.41
acpi_ns_search_node              53676    95336   41660   +77.61
acpi_pci_link_allocate          101769   179334   77565   +76.22
acpi_ev_execute_reg_method       16780    30654   13874   +82.68
acpi_ex_create_region            39552    68832   29280   +74.03
acpi_power_transition           105643   186893   81250   +76.91
acpi_ut_track_allocation         (new)   148056  148056
acpi_pci_link_get_irq           102014   179666   77652   +76.12
acpi_rs_irq_resource             73804   132208   58404   +79.13
acpi_rs_address64_stream         69551   121992   52441   +75.40
acpi_ev_queue_notify_request     19483    36147   16664   +85.53
acpi_pci_link_check_possible    100936   177576   76640   +75.93
acpi_ec_space_handler            98902   174308   75406   +76.24
acpi_tb_init_table_descriptor    80482   142748   62266   +77.37
acpi_ut_release_mutex            86683   154983   68300   +78.79
acpi_ds_eval_region_operands      7319    12880    5561   +75.98
acpi_remove_gpe_handler          22604    41358   18754   +82.97
acpi_ns_load_table               53104    94060   40956   +77.12
acpi_ec_write                    98073   173185   75112   +76.59
acpi_rs_extended_irq_resource    74190   132750   58560   +78.93
acpi_ut_acquire_mutex            86572   154633   68061   +78.62
acpi_ut_update_ref_count         89722   160901   71179   +79.33
acpi_bus_get_power_flags        107381   190159   82778   +77.09
acpi_ec_read                     97849   172833   74984   +76.63
acpi_ex_opcode_2A_2T_1R          42209    72560   30351   +71.91
acpi_hw_register_write           49401    88052   38651   +78.24
acpi_ds_build_internal_package   11041    19857    8816   +79.85
acpi_system_read_debug           (new)   189252  189252
acpi_ut_dump_buffer              83500   149816   66316   +79.42
acpi_bus_receive_event           97232   171529   74297   +76.41
acpi_ut_walk_package_tree        87099   156207   69108   +79.34
acpi_ds_eval_data_object_opera    7463    13225    5762   +77.21
acpi_rs_list_to_byte_stream      71498   125339   53841   +75.30
acpi_ns_init_one_object          59633   107836   48203   +80.83
acpi_pci_link_get_current       101241   178289   77048   +76.10
acpi_ds_method_data_get_value     5770     9672    3902   +67.63
acpi_ex_get_object_reference     40344    70104   29760   +73.77
acpi_ds_create_buffer_field       4028     6512    2484   +61.67
acpi_pci_irq_derive             103355   182176   78821   +76.26
acpi_ns_get_device_callback      54752    97617   42865   +78.29
acpi_power_on                   104848   185326   80478   +76.76
acpi_remove_address_space_hand   23030    42006   18976   +82.40
acpi_ut_validate_fadt            84994   152191   67197   +79.06
acpi_ds_build_internal_buffer_   10829    19481    8652   +79.90
acpi_ds_eval_buffer_field_oper    7163    12499    5336   +74.49
acpi_device_set_id              109391   192923   83532   +76.36
acpi_ec_start                    99847   175852   76005   +76.12
acpi_ex_access_region            32314    57307   24993   +77.34
acpi_ns_load_table_by_type       53249    94406   41157   +77.29
acpi_load_tables                 78696   139556   60860   +77.34
acpi_ds_execute_arguments         6260    10736    4476   +71.50
acpi_ex_opcode_2A_0T_1R          43196    73753   30557   +70.74
acpi_tb_convert_table_fadt       76754   136241   59487   +77.50
acpi_ex_store_object_to_object   47067    84042   36975   +78.56
acpi_ut_dump_allocations         (new)   148757  148757
acpi_enable_subsystem            87645   156995   69350   +79.13
acpi_power_add                  106124   187759   81635   +76.92
acpi_enter_sleep_state_prep      49952    89075   39123   +78.32
acpi_tb_find_table               81328   144124   62796   +77.21
acpi_ex_acquire_mutex            45534    81330   35796   +78.61
acpi_ns_walk_namespace           60682   109835   49153   +81.00
acpi_pci_bind_root              104386   184256   79870   +76.51
acpi_evaluate_integer             3754     5281    1527   +40.68
acpi_ex_convert_to_integer       30872    54972   24100   +78.06
acpi_ex_convert_to_target_type   31957    56468   24511   +76.70
acpi_ds_init_aml_walk            15551    28296   12745   +81.96
acpi_ex_opcode_3A_1T_1R          46340    82601   36261   +78.25
acpi_rs_address16_resource       68076   120112   52036   +76.44
acpi_tb_convert_fadt1            75753   135240   59487   +78.53
acpi_ds_scope_stack_push          9411    16548    7137   +75.84
acpi_ex_name_segment             28679    51404   22725   +79.24
acpi_ds_terminate_control_meth   10396    18771    8375   +80.56
acpi_rs_address32_resource       68643   120834   52191   +76.03
acpi_power_off_device           105007   185695   80688   +76.84
acpi_ds_load1_end_op             13224    23686   10462   +79.11
acpi_ns_attach_object            60012   108660   48648   +81.06
acpi_ns_build_internal_name      57524   102534   45010   +78.25
acpi_ns_evaluate_relative        56120    99712   43592   +77.68
acpi_ec_ecdt_probe                3127     3471     344   +11.00
acpi_ex_setup_region             32200    56876   24676   +76.63
acpi_hw_register_read            49065    87615   38550   +78.57
acpi_os_wait_semaphore            2720     3567     847   +31.14
acpi_ex_store_object_to_index    44557    76428   31871   +71.53
acpi_ut_evaluate_object          83986   150382   66396   +79.06
acpi_ps_get_next_walk_op         66552   117600   51048   +76.70
acpi_bus_scan                   110198   193861   83663   +75.92
acpi_ds_get_predicate_value       8216    14368    6152   +74.88
acpi_rs_address64_resource       69200   121547   52347   +75.65
acpi_ev_detach_region            17296    31676   14380   +83.14
acpi_ec_add                      99418   175213   75795   +76.24
acpi_ex_store_object_to_node     44775    76870   32095   +71.68
acpi_get_object_info             59062   105023   45961   +77.82
acpi_ds_parse_method              9596    17232    7636   +79.57
acpi_ns_init_one_device          59834   108197   48363   +80.83
acpi_ut_divide                   91678   163857   72179   +78.73
acpi_pci_link_add               102123   180006   77883   +76.26
acpi_hw_set_mode                 47338    84566   37228   +78.64
acpi_ds_exec_begin_op             8417    14813    6396   +75.99
acpi_reserve_resources            4517     5993    1476   +32.68
acpi_tb_get_this_table           77730   137858   60128   +77.35
acpi_ev_gpe_dispatch             24179    43980   19801   +81.89
acpi_ps_get_next_arg             62512   112504   49992   +79.97
acpi_system_alarm_seq_show       94141   167477   73336   +77.90
acpi_ex_write_with_update_rule   32937    58440   25503   +77.43
acpi_bus_add                    109832   193365   83533   +76.06
acpi_ns_search_and_enter         53836    95986   42150   +78.29
acpi_rs_dump_address32           (new)   130547  130547
acpi_ex_load_table_op            26758    48292   21534   +80.48
acpi_rs_dump_address16           (new)   130034  130034
acpi_ex_convert_to_string        31608    55954   24346   +77.02
acpi_ex_release_mutex            45781    81734   35953   +78.53
acpi_rs_dump_address64           (new)   131049  131049
acpi_ex_opcode_6A_0T_1R          29324    52544   23220   +79.18
acpi_ps_complete_this_op         62939   113039   50100   +79.60
acpi_ex_do_logical_op            41637    71819   30182   +72.49
acpi_ev_create_gpe_info_blocks   25574    46438   20864   +81.58
acpi_ev_create_gpe_block         25930    46962   21032   +81.11
acpi_ds_get_field_names           4275     6879    2604   +60.91
acpi_get_sleep_type_data         48245    86085   37840   +78.43
acpi_pci_irq_add_prt            102908   181349   78441   +76.22
acpi_install_notify_handler      21491    39885   18394   +85.59
acpi_ex_read_data_from_field     27652    49712   22060   +79.78
acpi_ev_gpe_initialize           26186    47497   21311   +81.38
acpi_ev_initialize_region        20945    38712   17767   +84.83
acpi_ds_store_object_to_local     5970    10180    4210   +70.52
acpi_ps_get_next_namepath        61708   111383   49675   +80.50
acpi_ds_is_result_used           11808    20988    9180   +77.74
acpi_ex_do_concatenate           40750    70779   30029   +73.69
acpi_ex_resolve_multiple         30215    53867   23652   +78.28
acpi_ut_strtoul64                85900   153513   67613   +78.71
acpi_pci_irq_enable             103517   182544   79027   +76.34
acpi_ds_init_buffer_field         6809    11937    5128   +75.31
acpi_ns_externalize_name         57890   103206   45316   +78.28
acpi_ds_init_object_from_op      11385    20411    9026   +79.28
acpi_ex_resolve_object_to_valu   29798    53282   23484   +78.81
acpi_tb_convert_fadt2            76164   135651   59487   +78.10
acpi_ds_exec_end_control_op       7826    13774    5948   +76.00
acpi_tb_find_rsdp                82441   145897   63456   +76.97
acpi_rs_get_list_length          73099   128153   55054   +75.31
acpi_bus_set_power               96725   170602   73877   +76.38
acpi_remove_notify_handler       21938    40428   18490   +84.28
acpi_ex_get_name_string          28812    51816   23004   +79.84
acpi_rs_byte_stream_to_list      70976   124718   53742   +75.72
acpi_ps_parse_aml                65652   116490   50838   +77.44
acpi_ut_delete_internal_obj      89440   160168   70728   +79.08
acpi_ds_load1_begin_op           12823    23059   10236   +79.83
acpi_psx_execute                 67648   119480   51832   +76.62
acpi_evaluate_object             54213    96800   42587   +78.55
acpi_ev_pci_config_region_setu   20432    37860   17428   +85.30
acpi_ev_install_space_handler    17671    32538   14867   +84.13
acpi_set_register                48714    86948   38234   +78.49
acpi_ds_call_control_method       9896    17867    7971   +80.55
acpi_tb_get_required_tables      79746   141427   61681   +77.35
acpi_ex_insert_into_field        34023    60176   26153   +76.87
acpi_pci_link_set               101382   178650   77268   +76.21
acpi_ev_address_space_dispatch   17000    30987   13987   +82.28
acpi_ex_field_datum_io           32519    57751   25232   +77.59
acpi_ut_init_globals             91007   162953   71946   +79.06
acpi_ex_extract_from_field       33402    59452   26050   +77.99
acpi_enter_sleep_state           50271    89475   39204   +77.99
acpi_leave_sleep_state           50860    90467   39607   +77.87
acpi_ut_update_object_referenc   89803   161251   71448   +79.56
acpi_ex_system_memory_space_ha   43512    74144   30632   +70.40
acpi_ex_resolve_node_to_value    46676    83012   36336   +77.85
acpi_ds_create_operand           12219    21951    9732   +79.65
acpi_ex_load_op                  27097    48795   21698   +80.08
acpi_pci_root_add               100382   176678   76296   +76.01
acpi_ns_root_initialize          51704    91664   39960   +77.29
acpi_ex_prep_field_value         37638    64811   27173   +72.20
acpi_ds_load2_begin_op           13514    24105   10591   +78.37
acpi_pci_bind                   103978   183463   79485   +76.44
acpi_evaluate_reference           3838     5688    1850   +48.20
acpi_ex_opcode_2A_1T_1R          42482    72912   30430   +71.63
acpi_ds_load2_end_op             14074    24887   10813   +76.83
acpi_ex_store                    44280    75552   31272   +70.62
acpi_rs_create_pci_routing_tab   69901   122574   52673   +75.35
acpi_ex_write_data_to_field      27993    50259   22266   +79.54
acpi_extract_package              3144     4332    1188   +37.79
acpi_get_firmware_table          81572   144524   62952   +77.17
acpi_ex_dump_operand             (new)    78224   78224
acpi_ds_exec_end_op               8691    15291    6600   +75.94
acpi_ex_opcode_1A_0T_1R          36419    63139   26720   +73.37
acpi_system_write_alarm          94712   168089   73377   +77.47
acpi_ns_dump_one_object          (new)   105735  105735
acpi_ns_lookup                   52318    92442   40124   +76.69
acpi_ex_dump_object_descriptor   (new)    79726   79726
acpi_ex_opcode_1A_1T_1R          34943    61473   26530   +75.92
acpi_ex_resolve_operands         38081    65711   27630   +72.56
acpi_ps_parse_loop               63507   113826   50319   +79.23




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
