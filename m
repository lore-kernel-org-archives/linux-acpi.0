From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CONFIG_ACPI_DEBUG cost
Date: 05 Nov 2004 02:54:39 -0500
Message-ID: <1099641278.13840.630.camel@d845pe>
References: <37F890616C995246BE76B3E6B2DBE0550276533A@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE0550276533A-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

previous bloat-o-meter output was junk -- nm --size-sort didn't work
on the machine i ran on and it tricked the script.  This looks better.

CONFIG_ACPI_DEBUG disabled vs enabled


Symbol                         Old size  New size  Delta     Change (%)
__initcall_acpi_debug_init       (new)        4       4
acpi_ut_init_stack_ptr_trace     (new)        9       9
acpi_ps_get_opcode_name              6       15       9  +150.00
acpi_ut_create_generic_state        16       21       5   +31.25
acpi_ex_out_integer              (new)       22      22
acpi_ex_out_pointer              (new)       22      22
acpi_ex_out_string               (new)       22      22
acpi_ut_get_mutex_name           (new)       22      22
acpi_ps_init_op                     16       25       9   +56.25
acpi_hw_clear_gpe                   23       30       7   +30.43
acpi_ns_get_parent_node             24       31       7   +29.17
acpi_ex_system_do_suspend           32       37       5   +15.62
acpi_ut_track_stack_ptr          (new)       38      38
acpi_ns_map_handle_to_node          35       39       4   +11.43
acpi_tb_get_table_count             34       39       5   +14.71
acpi_ut_exit                     (new)       39      39
acpi_hw_write_gpe_enable_reg        36       41       5   +13.89
acpi_ex_out_address              (new)       42      42
acpi_ex_truncate_for32bit_tabl      35       42       7   +20.00
acpi_rs_get_resource_type           32       42      10   +31.25
acpi_ut_debug_print_raw          (new)       42      42
acpi_ut_get_object_size             34       43       9   +26.47
acpi_ut_ptr_exit                 (new)       43      43
acpi_ut_trace                    (new)       44      44
acpi_ut_strupr                      41       46       5   +12.20
acpi_ut_dword_byte_swap             40       47       7   +17.50
acpi_ut_fadt_register_error         46       47       1    +2.17
acpi_ut_trace_ptr                (new)       48      48
acpi_ut_trace_str                (new)       48      48
acpi_ut_trace_u32                (new)       48      48
acpi_ut_valid_acpi_character        43       48       5   +11.63
acpi_ns_dump_entry               (new)       50      50
acpi_ns_get_pathname_length         45       50       5   +11.11
acpi_rs_dump_fixed_io            (new)       50      50
acpi_bus_data_handler                1       51      50  +5000.0
acpi_pci_data_handler                1       51      50  +5000.0
acpi_ut_find_allocation          (new)       53      53
acpi_ex_system_reset_event          50       55       5   +10.00
acpi_ut_create_pkg_state_and_p      48       55       7   +14.58
acpi_ut_dump_allocation_info     (new)       57      57
acpi_ns_remove_reference            54       59       5    +9.26
acpi_tb_get_rsdt_address            52       60       8   +15.38
acpi_ev_cmos_region_setup            3       61      58  +1933.3
acpi_ev_pci_bar_region_setup         3       61      58  +1933.3
acpi_ex_cmos_space_handler           3       61      58  +1933.3
acpi_ex_pci_bar_space_handler        3       61      58  +1933.3
acpi_ut_create_update_state_an      52       61       9   +17.31
acpi_ut_valid_acpi_name             56       61       5    +8.93
acpi_ev_global_lock_thread          61       62       1    +1.64
acpi_ut_value_exit               (new)       63      63
acpi_ds_delete_walk_state_cach       9       64      55  +611.11
acpi_ut_delete_generic_cache        44       64      20   +45.45
acpi_ut_delete_generic_state_c       9       64      55  +611.11
acpi_ut_delete_object_cache          9       64      55  +611.11
acpi_ev_valid_gpe_event             63       68       5    +7.94
acpi_ns_dump_objects             (new)       68      68
acpi_rs_dump_vendor_specific     (new)       68      68
acpi_ut_delete_generic_state        14       68      54  +385.71
acpi_tb_delete_single_table         56       70      14   +25.00
acpi_ps_delete_parse_cache          17       71      54  +317.65
acpi_ps_get_arg                     67       72       5    +7.46
acpi_ev_gpe_xrupt_handler           11       73      62  +563.64
acpi_ds_get_current_walk_state      14       74      60  +428.57
acpi_ex_release_all_mutexes         69       74       5    +7.25
acpi_ex_system_do_stall             69       75       6    +8.70
acpi_hw_get_bit_register_info       19       75      56  +294.74
acpi_ut_push_generic_state          16       76      60  +375.00
acpi_ev_sci_xrupt_handler           24       77      53  +220.83
acpi_rs_dump_fixed_memory32      (new)       77      77
acpi_hw_enable_all_runtime_gpe      17       78      61  +358.82
acpi_hw_enable_all_wakeup_gpes      17       78      61  +358.82
acpi_terminate                      15       79      64  +426.67
acpi_ps_get_next_package_end        20       80      60  +300.00
acpi_ds_push_walk_state             21       81      60  +285.71
acpi_purge_cached_objects           23       81      58  +252.17
acpi_ut_pop_generic_state           18       81      63  +350.00
acpi_ns_get_next_node               74       83       9   +12.16
acpi_rs_end_depend_fns_stream       21       83      62  +295.24
acpi_ev_remove_sci_handler          23       84      61  +265.22
acpi_ut_status_exit              (new)       85      85
acpi_ds_pop_walk_state              23       86      63  +273.91
acpi_rs_end_tag_stream              25       87      62  +248.00
acpi_ut_mutex_terminate             30       89      59  +196.67
acpi_ev_install_sci_handler         30       90      60  +200.00
acpi_ex_system_signal_event         23       90      67  +291.30
acpi_hw_disable_all_gpes            32       90      58  +181.25
acpi_ev_default_region_setup        28       92      64  +228.57
acpi_ev_io_space_region_setup       28       92      64  +228.57
acpi_ps_free_op                     26       92      66  +253.85
acpi_os_delete_lock                  5       94      89  +1780.0
acpi_set_firmware_waking_vecto      35       94      59  +168.57
acpi_rs_end_tag_resource            42       96      54  +128.57
acpi_ex_system_wait_event           30       97      67  +223.33
acpi_ut_allocate_and_track       (new)       97      97
irqrouter_resume                    36      100      64  +177.78
acpi_ut_create_control_state        25      101      76  +304.00
acpi_ev_init_global_lock_handl      39      102      63  +161.54
acpi_ex_exit_interpreter            46      102      56  +121.74
acpi_rs_end_depend_fns_resourc      42      102      60  +142.86
acpi_ds_result_stack_push           40      103      63  +157.50
acpi_ex_enter_interpreter           49      103      54  +110.20
acpi_ps_alloc_op                    98      103       5    +5.10
acpi_ut_create_thread_state         29      103      74  +255.17
acpi_ds_scope_stack_clear           35      104      69  +197.14
acpi_hw_get_gpe_status              99      104       5    +5.05
acpi_ev_execute_reg_methods         40      105      65  +162.50
acpi_ev_notify_dispatch            100      105       5    +5.00
acpi_ex_unsigned_integer_to_st      94      105      11   +11.70
acpi_ns_attach_data                104      105       1    +0.96
acpi_rs_dump_io                  (new)      105     105
acpi_rs_dump_memory24            (new)      105     105
acpi_rs_dump_memory32            (new)      105     105
acpi_ps_cleanup_scope               36      106      70  +194.44
acpi_tb_handle_to_object            49      106      57  +116.33
acpi_rs_fixed_io_stream             43      107      64  +148.84
acpi_ut_delete_internal_object      37      108      71  +191.89
acpi_os_create_lock                 23      109      86  +373.91
acpi_ev_fixed_event_dispatch       105      111       6    +5.71
acpi_ds_clear_operands              50      112      62  +124.00
acpi_get_timer_resolution           41      112      71  +173.17
acpi_ev_get_gpe_event_info         108      113       5    +4.63
acpi_get_timer                      36      113      77  +213.89
acpi_ns_print_node_pathname        100      113      13   +13.00
acpi_ds_obj_stack_delete_all        48      114      66  +137.50
acpi_ns_dump_root_devices        (new)      115     115
acpi_ns_get_secondary_object        30      117      87  +290.00
acpi_os_execute_deferred            27      117      90  +333.33
acpi_ps_get_depth_next             112      117       5    +4.46
acpi_ut_valid_internal_object       19      117      98  +515.79
acpi_ns_create_node                 46      118      72  +156.52
acpi_ns_dump_pathname            (new)      118     118
acpi_ut_create_update_state         36      118      82  +227.78
acpi_ds_resolve_operands            52      119      67  +128.85
acpi_ex_check_object_type           53      119      66  +124.53
acpi_pci_root_remove                34      119      85  +250.00
acpi_ec_remove_fs                   58      120      62  +106.90
acpi_power_remove_fs                58      120      62  +106.90
acpi_ps_get_opcode_info             59      120      61  +103.39
acpi_ut_copy_iobject_to_eobjec      53      120      67  +126.42
acpi_rs_fixed_io_resource           60      122      62  +103.33
acpi_ec_remove                      38      123      85  +223.68
acpi_ex_release_global_lock         63      123      60   +95.24
acpi_ns_get_internal_name_leng     118      123       5    +4.24
acpi_pci_root_init                  29      123      94  +324.14
acpi_clear_event                    38      124      86  +226.32
acpi_rs_fixed_memory32_stream       60      124      64  +106.67
acpi_install_exception_handler      52      125      73  +140.38
acpi_system_sleep_seq_show          85      125      40   +47.06
acpi_ut_add_reference               28      125      97  +346.43
acpi_ut_mutex_initialize            33      125      92  +278.79
acpi_ev_global_lock_handler        126      127       1    +0.79
acpi_ns_parse_table                 37      127      90  +243.24
acpi_os_release_lock                17      127     110  +647.06
acpi_power_remove                   44      127      83  +188.64
acpi_ps_append_arg                 121      127       6    +4.96
acpi_ex_eisa_id_to_string          123      128       5    +4.07
acpi_get_firmware_waking_vecto      53      129      76  +143.40
acpi_ut_callocate_and_track      (new)      129     129
acpi_ut_delete_object_desc          20      129     109  +545.00
acpi_ex_data_table_space_handl      49      130      81  +165.31
acpi_hw_initialize                  26      130     104  +400.00
acpi_rs_get_prt_method_data         62      130      68  +109.68
acpi_rs_start_depend_fns_strea      64      130      66  +103.12
acpi_ut_copy_eobject_to_iobjec      27      131     104  +385.19
acpi_os_acquire_lock                22      132     110  +500.00
acpi_os_delete_semaphore            23      132     109  +473.91
acpi_rs_io_stream                   68      132      64   +94.12
acpi_ut_create_pkg_state            50      132      82  +164.00
acpi_ex_acquire_global_lock         32      133     101  +315.62
acpi_ns_print_pathname           (new)      133     133
acpi_pci_link_resume                33      133     100  +303.03
acpi_rs_fixed_memory32_resourc      73      133      60   +82.19
acpi_ut_copy_ielement_to_eelem     121      133      12    +9.92
acpi_ns_get_type                    46      134      88  +191.30
acpi_rs_dump_irq_list            (new)      134     134
acpi_get_irq_routing_table          48      135      87  +181.25
acpi_ps_init_scope                  62      135      73  +117.74
irqrouter_init_sysfs                48      135      87  +181.25
acpi_rs_dump_start_depend_fns    (new)      136     136
acpi_tb_verify_table_checksum       77      136      59   +76.62
acpi_ds_result_stack_pop            42      138      96  +228.57
acpi_ex_unload_table                59      138      79  +133.90
acpi_ns_unload_namespace            33      138     105  +318.18
acpi_rs_get_method_data             61      138      77  +126.23
acpi_rs_get_crs_method_data         62      139      77  +124.19
acpi_rs_get_prs_method_data         62      139      77  +124.19
acpi_rs_memory32_range_stream       76      140      64   +84.21
acpi_unload_table                   55      140      85  +154.55
acpi_ut_initialize_buffer          139      140       1    +0.72
acpi_ds_obj_stack_get_value         43      141      98  +227.91
acpi_ds_obj_stack_pop               56      141      85  +151.79
acpi_ev_walk_gpe_list               86      141      55   +63.95
acpi_ut_evaluate_numeric_objec      57      141      84  +147.37
acpi_bus_unregister_driver          77      142      65   +84.42
acpi_ev_initialize_op_regions       60      142      82  +136.67
acpi_ns_terminate                   45      142      97  +215.56
acpi_pci_link_remove                57      142      85  +149.12
acpi_ds_method_data_delete_val      70      143      73  +104.29
acpi_rs_io_resource                 84      143      59   +70.24
acpi_set_current_resources          49      143      94  +191.84
acpi_ut_remove_reference            37      143     106  +286.49
acpi_ds_obj_stack_push              42      144     102  +242.86
acpi_ns_build_external_path         80      144      64   +80.00
acpi_set_gpe_type                   62      144      82  +132.26
acpi_ut_delete_mutex                52      144      92  +176.92
acpi_ex_system_release_mutex        40      145     105  +262.50
acpi_rs_memory32_range_resourc      85      145      60   +70.59
acpi_rs_vendor_stream               81      145      64   +79.01
acpi_get_event_status               45      146     101  +224.44
acpi_rs_memory24_resource           89      146      57   +64.04
acpi_get_current_resources          48      147      99  +206.25
acpi_get_possible_resources         48      147      99  +206.25
acpi_rs_memory24_stream             84      148      64   +76.19
acpi_ds_method_data_init            97      149      52   +53.61
acpi_ev_fixed_event_detect          89      149      60   +67.42
acpi_ns_local                       62      150      88  +141.94
acpi_clear_gpe                      79      151      72   +91.14
acpi_disable_gpe                    79      151      72   +91.14
acpi_ut_copy_ipackage_to_epack      93      151      58   +62.37
acpi_ut_release_to_cache           133      151      18   +13.53
acpi_ev_set_gpe_type                67      153      86  +128.36
acpi_pci_link_init                  59      153      94  +159.32
acpi_enable_gpe                     82      154      72   +87.80
acpi_ex_create_event                95      154      59   +62.11
acpi_ex_get_buffer_datum            86      154      68   +79.07
acpi_ex_set_buffer_datum            75      154      79  +105.33
acpi_hw_get_mode                    58      155      97  +167.24
acpi_power_seq_show                 91      155      64   +70.33
acpi_ut_allocate_object_desc_d      49      155     106  +216.33
acpi_enable_wakeup_device_prep     113      156      43   +38.05
acpi_get_gpe_status                 84      156      72   +85.71
acpi_ps_get_next_namestring         96      157      61   +63.54
acpi_ut_create_mutex                74      157      83  +112.16
acpi_ut_debug_print              (new)      157     157
acpi_ev_delete_gpe_handlers         81      158      77   +95.06
acpi_system_read_info               94      158      64   +68.09
acpi_ut_get_package_object_siz      80      158      78   +97.50
acpi_bus_get_device                 50      159     109  +218.00
acpi_system_read_dsdt               88      159      71   +80.68
acpi_ut_subsystem_shutdown          37      159     122  +329.73
acpi_ns_dump_tables              (new)      160     160
acpi_ut_display_init_pathname    (new)      160     160
acpi_ex_digits_needed               77      161      84  +109.09
acpi_ns_delete_namespace_subtr      93      161      68   +73.12
acpi_ns_get_attached_object         37      161     124  +335.14
acpi_bus_check_scope                40      162     122  +305.00
acpi_ex_dump_operands            (new)      162     162
acpi_ns_opens_scope                 63      162      99  +157.14
acpi_ns_report_error               150      162      12    +8.00
acpi_rs_dump_irq                 (new)      163     163
acpi_ut_copy_iobject_to_iobjec      80      163      83  +103.75
acpi_ds_method_data_get_type        58      164     106  +182.76
acpi_event_init                     60      164     104  +173.33
acpi_ev_install_region_handler      88      164      76   +86.36
acpi_find_root_pointer              62      165     103  +166.13
acpi_ex_create_alias               106      166      60   +56.60
acpi_ex_system_acquire_mutex        61      166     105  +172.13
acpi_rs_dma_stream                 100      166      66   +66.00
acpi_ds_obj_stack_pop_and_dele      80      167      87  +108.75
acpi_tb_uninstall_table             70      167      97  +138.57
acpi_ex_opcode_1A_1T_0R             84      168      84  +100.00
acpi_ns_get_external_pathname    (new)      168     168
acpi_ps_get_child                  171      168      -3    -1.75
acpi_system_read_fadt               88      168      80   +90.91
acpi_ns_delete_node                 93      169      76   +81.72
acpi_tb_convert_to_xsdt            163      169       6    +3.68
acpi_tb_get_table_body              77      169      92  +119.48
acpi_ut_execute_HID                 86      169      83   +96.51
acpi_pci_irq_find_prt_entry         98      170      72   +73.47
acpi_ut_execute_UID                 87      170      83   +95.40
acpi_ns_detach_object               65      171     106  +163.08
acpi_tb_recognize_table             62      171     109  +175.81
acpi_ds_begin_method_execution      69      173     104  +150.72
acpi_ev_attach_region               41      173     132  +321.95
acpi_power_get_context              56      174     118  +210.71
acpi_ds_delete_result_if_not_u      64      175     111  +173.44
acpi_tb_get_table                   96      175      79   +82.29
acpi_ev_system_memory_region_s      92      176      84   +91.30
acpi_os_signal_semaphore            55      176     121  +220.00
acpi_ps_push_scope                  89      176      87   +97.75
acpi_bus_scan_fixed                 94      177      83   +88.30
acpi_get_devices                    94      177      83   +88.30
acpi_ut_allocate                    90      177      87   +96.67
acpi_ex_create_power_resource      100      179      79   +79.00
acpi_ds_get_buffer_field_argum      48      180     132  +275.00
acpi_ec_stop                        78      180     102  +130.77
acpi_os_create_semaphore            75      181     106  +141.33
acpi_ds_method_data_set_value       54      182     128  +237.04
acpi_walk_namespace                 97      182      85   +87.63
acpi_ex_system_wait_semaphore       74      183     109  +147.30
acpi_ps_pop_scope                  100      183      83   +83.00
acpi_rs_vendor_resource            121      183      62   +51.24
acpi_bus_register_driver            80      184     104  +130.00
acpi_ns_dump_one_device          (new)      184     184
acpi_scan_init                     102      184      82   +80.39
acpi_ut_terminate                   70      185     115  +164.29
acpi_bus_find_driver               121      186      65   +53.72
acpi_irq_penalty_init              123      187      64   +52.03
acpi_ex_create_mutex               115      188      73   +63.48
acpi_ex_create_processor           109      188      79   +72.48
acpi_ns_get_object_value            79      188     109  +137.97
acpi_ds_exec_begin_control_op      124      189      65   +52.42
acpi_ns_load_namespace              45      189     144  +320.00
acpi_ut_execute_STA                 67      189     122  +182.09
acpi_ds_create_walk_state          109      191      82   +75.23
acpi_driver_detach                 128      192      64   +50.00
acpi_ps_get_next_package_lengt     136      194      58   +42.65
acpi_ds_method_data_delete_all      72      195     123  +170.83
acpi_ev_install_gpe_block          115      195      80   +69.57
acpi_format_exception              133      195      62   +46.62
acpi_pci_link_get_possible          46      195     149  +323.91
acpi_ev_install_xrupt_handlers     110      196      86   +78.18
acpi_ds_create_node                 95      198     103  +108.42
acpi_enable                         74      199     125  +168.92
acpi_ex_do_logical_numeric_op      116      199      83   +71.55
acpi_ex_system_io_space_handle      78      199     121  +155.13
acpi_ds_get_buffer_arguments        76      201     125  +164.47
acpi_ds_get_package_arguments       76      201     125  +164.47
acpi_ns_handle_to_pathname          69      201     132  +191.30
acpi_ut_short_divide               106      201      95   +89.62
acpi_install_address_space_han     110      202      92   +83.64
acpi_remove_gpe_block              103      202      99   +96.12
acpi_rs_irq_stream                 142      202      60   +42.25
acpi_disable                        45      203     158  +351.11
acpi_ut_create_internal_object     108      204      96   +88.89
acpi_ex_decode_field_access         92      205     113  +122.83
acpi_ec_init                        86      206     120  +139.53
acpi_rs_start_depend_fns_resou     111      207      96   +86.49
acpi_ds_get_region_arguments        62      208     146  +235.48
acpi_ec_add_fs                      98      209     111  +113.27
acpi_ex_common_buffer_setup         62      209     147  +237.10
acpi_ds_result_insert               53      210     157  +296.23
acpi_ut_create_string_object       116      210      94   +81.03
acpi_ut_osi_implementation         130      210      80   +61.54
acpi_ns_find_parent_name            32      211     179  +559.38
acpi_power_get_state                70      212     142  +202.86
acpi_ds_result_pop                  78      213     135  +173.08
acpi_ev_release_global_lock        122      213      91   +74.59
acpi_ex_pci_config_space_handl      90      213     123  +136.67
acpi_tb_delete_tables_by_type      136      213      77   +56.62
acpi_ev_disable_gpe                103      214     111  +107.77
acpi_ns_delete_subtree             125      214      89   +71.20
acpi_ut_allocate_owner_id          140      214      74   +52.86
acpi_ds_create_field               138      215      77   +55.80
acpi_ex_opcode_0A_0T_1R            139      215      76   +54.68
acpi_ut_copy_ipackage_to_ipack     140      215      75   +53.57
acpi_ex_opcode_2A_0T_0R            109      216     107   +98.17
acpi_ut_execute_sxds                79      216     137  +173.42
acpi_power_init                    106      217     111  +104.72
acpi_ev_initialize_events          109      218     109  +100.00
acpi_ex_dump_node                (new)      218     218
acpi_ex_resolve_to_value            70      218     148  +211.43
acpi_ns_delete_namespace_by_ow     151      218      67   +44.37
acpi_hw_low_level_write             89      219     130  +146.07
acpi_ev_delete_gpe_xrupt           111      220     109   +98.20
acpi_ds_create_operands             61      222     161  +263.93
acpi_tb_match_signature             94      222     128  +136.17
acpi_bus_init                      137      223      86   +62.77
acpi_ev_terminate                   77      223     146  +189.61
acpi_ex_allocate_name_string       143      224      81   +56.64
acpi_get_handle                    220      225       5    +2.27
acpi_rs_dump_dma                 (new)      225     225
acpi_tb_get_primary_table          110      225     115  +104.55
acpi_ut_create_buffer_object       127      225      98   +77.17
acpi_ds_method_data_init_args       75      226     151  +201.33
acpi_ev_update_gpe_enable_mask     118      226     108   +91.53
acpi_hw_low_level_read              95      226     131  +137.89
acpi_rs_dump_extended_irq        (new)      226     226
acpi_ds_restart_control_method      68      227     159  +233.82
acpi_get_timer_duration            117      227     110   +94.02
acpi_ut_acquire_from_cache         158      227      69   +43.67
acpi_remove_fixed_event_handle      75      228     153  +204.00
acpi_tb_scan_memory_for_rsdp        84      228     144  +171.43
acpi_ut_free_and_track           (new)      228     228
acpi_ut_callocate                  121      229     108   +89.26
acpi_ex_opcode_1A_0T_0R            144      230      86   +59.72
acpi_ut_copy_simple_object         229      231       2    +0.87
acpi_ec_read_info                  164      232      68   +41.46
acpi_ds_result_push                 95      233     138  +145.26
acpi_rs_get_pci_routing_table_     171      233      62   +36.26
acpi_power_get_inferred_state      109      234     125  +114.68
acpi_initialize_subsystem          141      235      94   +66.67
acpi_system_write_debug          (new)      235     235
acpi_driver_attach                 129      236     107   +82.95
acpi_ev_enable_gpe                 117      236     119  +101.71
acpi_ns_install_node                96      236     140  +145.83
acpi_ns_one_complete_parse         124      236     112   +90.32
acpi_hw_clear_acpi_status          137      237     100   +72.99
acpi_pci_link_check_current         66      237     171  +259.09
acpi_ps_delete_parse_tree          148      237      89   +60.14
acpi_rs_create_resource_list        81      238     157  +193.83
acpi_rs_extended_irq_stream        164      238      74   +45.12
acpi_ds_delete_walk_state          110      239     129  +117.27
acpi_bus_get_status                125      240     115   +92.00
acpi_ev_install_handler            168      240      72   +42.86
acpi_power_add_fs                  107      240     133  +124.30
acpi_tb_get_table_ptr              106      241     135  +127.36
acpi_ds_result_pop_from_bottom      85      242     157  +184.71
acpi_ex_create_method              161      242      81   +50.31
acpi_get_table_header              119      242     123  +103.36
acpi_get_system_info               145      243      98   +67.59
acpi_ex_add_table                  162      244      82   +50.62
acpi_ns_initialize_devices          82      244     162  +197.56
acpi_init                          140      247     107   +76.43
acpi_tb_install_table              138      247     109   +78.99
acpi_disable_event                  84      249     165  +196.43
acpi_enable_event                   86      249     163  +189.53
acpi_ex_prep_common_field_obje     162      250      88   +54.32
acpi_get_register                  121      250     129  +106.61
acpi_ns_internalize_name           127      250     123   +96.85
acpi_initialize_objects             61      252     191  +313.11
acpi_ns_execute_control_method      72      254     182  +252.78
acpi_ns_get_node_by_path           126      257     131  +103.97
acpi_ds_result_remove               58      258     200  +344.83
acpi_load_table                    156      259     103   +66.03
acpi_rs_create_byte_stream          74      260     186  +251.35
acpi_reserve_io_ranges             129      262     133  +103.10
acpi_tb_build_common_facs          176      262      86   +48.86
acpi_enter_sleep_state_s4bios      129      263     134  +103.88
acpi_ev_match_prw_and_gpe          184      264      80   +43.48
acpi_ds_create_index_field         177      265      88   +49.72
acpi_enable_wakeup_device          222      265      43   +19.37
acpi_debug_init                  (new)      267     267
acpi_ps_next_parse_state           199      267      68   +34.17
acpi_rs_set_srs_method_data        176      267      91   +51.70
acpi_ds_method_data_get_node        86      268     182  +211.63
acpi_install_fixed_event_handl     116      268     152  +131.03
acpi_ds_scope_stack_pop             43      269     226  +525.58
acpi_ex_store_buffer_to_buffer     166      269     103   +62.05
acpi_ex_resolve_object             151      270     119   +78.81
acpi_ev_acquire_global_lock        111      271     160  +144.14
acpi_tb_validate_rsdt              162      271     109   +67.28
acpi_tb_validate_table_header      131      271     140  +106.87
acpi_ex_store_string_to_string     171      272     101   +59.06
acpi_ps_get_next_field             188      272      84   +44.68
acpi_power_get_list_state          110      276     166  +150.91
acpi_ut_copy_ielement_to_ielem     241      276      35   +14.52
acpi_ut_get_simple_object_size     122      276     154  +126.23
acpi_bus_get_wakeup_device_fla     168      277     109   +64.88
acpi_ex_opcode_3A_0T_0R            148      277     129   +87.16
acpi_rs_dump_resource_list       (new)      278     278
acpi_os_queue_for_execution        138      280     142  +102.90
acpi_ns_evaluate_by_handle         142      281     139   +97.89
acpi_ex_do_math_op                 277      282       5    +1.81
acpi_rs_dma_resource               202      282      80   +39.60
acpi_ec_query                      186      283      97   +52.15
acpi_ex_convert_to_buffer          162      283     121   +74.69
acpi_ev_delete_gpe_block           159      284     125   +78.62
acpi_ns_initialize_objects          43      284     241  +560.47
acpi_install_gpe_block             201      285      84   +41.79
acpi_pci_irq_lookup                 95      285     190  +200.00
acpi_disable_wakeup_device         244      287      43   +17.62
acpi_ds_create_bank_field          194      287      93   +47.94
acpi_ds_initialize_objects          69      289     220  +318.84
acpi_ex_convert_to_ascii           282      292      10    +3.55
acpi_ds_build_internal_object      197      293      96   +48.73
acpi_tb_table_override             188      294     106   +56.38
acpi_ps_get_next_simple_arg        241      295      54   +22.41
acpi_ns_delete_children            121      298     177  +146.28
acpi_rs_address32_stream           236      298      62   +26.27
acpi_bus_get_flags                 234      299      65   +27.78
acpi_bus_driver_init               148      300     152  +102.70
acpi_ec_gpe_query                  229      300      71   +31.00
acpi_bus_generate_event            184      301     117   +63.59
acpi_ds_init_one_object            131      301     170  +129.77
acpi_ns_evaluate_by_name           113      301     188  +166.37
acpi_tb_get_secondary_table        160      302     142   +88.75
acpi_bus_init_irq                  179      303     124   +69.27
acpi_ds_init_field_objects         195      305     110   +56.41
acpi_system_init                   196      305     109   +55.61
acpi_ut_remove_allocation        (new)      305     305
acpi_bus_check_device               99      306     207  +209.09
acpi_os_get_pci_id                 113      308     195  +172.57
acpi_ex_concat_template            205      310     105   +51.22
acpi_tb_get_table_rsdt             109      310     201  +184.40
acpi_rs_address16_stream           241      311      70   +29.05
acpi_evaluate_object_typed         117      312     195  +166.67
acpi_get_table                     164      313     149   +90.85
acpi_install_gpe_handler           221      315      94   +42.53
acpi_pci_irq_add_entry             174      315     141   +81.03
acpi_ev_get_gpe_xrupt_block        168      316     148   +88.10
acpi_rs_get_byte_stream_length     223      317      94   +42.15
acpi_ns_search_parent_tree          96      318     222  +231.25
acpi_ut_copy_isimple_to_esimpl     229      318      89   +38.86
acpi_bus_get_power                 166      319     153   +92.17
acpi_system_read_event             213      321     108   +50.70
acpi_early_init                    237      322      85   +35.86
acpi_ut_execute_CID                214      323     109   +50.93
acpi_ev_save_method_info           127      324     197  +155.12
acpi_tb_get_table_header           197      324     127   +64.47
acpi_ex_create_table_region        219      325     106   +48.40
acpi_ev_asynch_execute_gpe_met     228      327      99   +43.42
acpi_walk_resources                226      327     101   +44.69
acpi_tb_verify_rsdp                235      328      93   +39.57
acpi_bus_notify                     68      329     261  +383.82
acpi_ev_gpe_detect                 254      331      77   +30.31
acpi_ut_copy_esimple_to_isimpl     203      331     128   +63.05
acpi_ns_search_node                 64      332     268  +418.75
acpi_pci_link_allocate             245      332      87   +35.51
acpi_ev_execute_reg_method         220      333     113   +51.36
acpi_ex_create_region              203      336     133   +65.52
acpi_disable_wakeup_device_pow     172      339     167   +97.09
acpi_power_transition              194      339     145   +74.74
acpi_ut_track_allocation         (new)      339     339
acpi_enable_wakeup_device_powe     186      340     154   +82.80
acpi_pci_link_get_irq              109      340     231  +211.93
acpi_rs_irq_resource               244      340      96   +39.34
acpi_rs_address64_stream           266      341      75   +28.20
acpi_ev_queue_notify_request       193      342     149   +77.20
acpi_ec_space_handler              196      344     148   +75.51
acpi_tb_init_table_descriptor      257      344      87   +33.85
acpi_ut_release_mutex              103      344     241  +233.98
acpi_ds_eval_region_operands       144      345     201  +139.58
acpi_remove_gpe_handler            216      345     129   +59.72
acpi_ns_load_table                 145      346     201  +138.62
acpi_rs_extended_irq_resource      268      349      81   +30.22
acpi_ut_acquire_mutex              111      350     239  +215.32
acpi_ut_update_ref_count            81      350     269  +332.10
acpi_ex_opcode_2A_2T_1R            273      352      79   +28.94
acpi_hw_register_write             279      354      75   +26.88
acpi_ec_write                      224      355     131   +58.48
acpi_ds_build_internal_package     249      356     107   +42.97
acpi_system_read_debug           (new)      356     356
acpi_ec_read                       225      359     134   +59.56
acpi_ut_walk_package_tree          211      359     148   +70.14
acpi_ds_eval_data_object_opera     239      360     121   +50.63
acpi_rs_list_to_byte_stream        247      360     113   +45.75
acpi_ns_init_one_object            201      361     160   +79.60
acpi_pci_link_get_current          141      361     220  +156.03
acpi_ds_method_data_get_value      130      365     235  +180.77
acpi_ex_get_object_reference       201      365     164   +81.59
acpi_ds_create_buffer_field        247      367     120   +48.58
acpi_pci_irq_derive                162      368     206  +127.16
acpi_ns_get_device_callback        330      369      39   +11.82
acpi_power_on                      159      369     210  +132.08
acpi_bus_get_power_flags           314      370      56   +17.83
acpi_remove_address_space_hand     151      372     221  +146.36
acpi_bus_receive_event             263      375     112   +42.59
acpi_ds_build_internal_buffer_     212      376     164   +77.36
acpi_ds_eval_buffer_field_oper     156      381     225  +144.23
acpi_device_set_id                 381      382       1    +0.26
acpi_ec_start                      198      385     187   +94.44
acpi_ex_access_region              148      387     239  +161.49
acpi_ns_load_table_by_type         222      387     165   +74.32
acpi_load_tables                   285      388     103   +36.14
acpi_ds_execute_arguments          266      390     124   +46.62
acpi_ex_opcode_2A_0T_1R            316      391      75   +23.73
acpi_tb_convert_table_fadt         241      391     150   +62.24
acpi_ex_store_object_to_object     244      392     148   +60.66
acpi_ut_dump_allocations         (new)      393     393
acpi_enable_subsystem               85      394     309  +363.53
acpi_power_add                     305      399      94   +30.82
acpi_enter_sleep_state_prep        319      400      81   +25.39
acpi_tb_find_table                 244      400     156   +63.93
acpi_ex_acquire_mutex              247      404     157   +63.56
acpi_ns_walk_namespace             261      404     143   +54.79
acpi_pci_bind_root                 226      405     179   +79.20
acpi_evaluate_integer               84      407     323  +384.52
acpi_ex_convert_to_integer         292      407     115   +39.38
acpi_ex_convert_to_target_type     240      408     168   +70.00
acpi_ds_init_aml_walk              276      410     134   +48.55
acpi_ex_opcode_3A_1T_1R            333      410      77   +23.12
acpi_rs_address16_resource         326      411      85   +26.07
acpi_ds_scope_stack_push           142      412     270  +190.14
acpi_ex_name_segment               133      412     279  +209.77
acpi_ds_terminate_control_meth     233      415     182   +78.11
acpi_rs_address32_resource         321      415      94   +29.28
acpi_power_off_device              169      418     249  +147.34
acpi_ds_load1_end_op               290      419     129   +44.48
acpi_ns_attach_object              240      419     179   +74.58
acpi_ns_build_internal_name        239      422     183   +76.57
acpi_ns_evaluate_relative          197      422     225  +114.21
acpi_pci_link_check_possible       193      422     229  +118.65
acpi_ex_setup_region               114      431     317  +278.07
acpi_hw_register_read              336      437     101   +30.06
acpi_os_wait_semaphore             220      441     221  +100.45
acpi_ex_store_object_to_index      218      442     224  +102.75
acpi_ut_evaluate_object            260      442     182   +70.00
acpi_ps_get_next_walk_op           262      443     181   +69.08
acpi_bus_scan                      365      444      79   +21.64
acpi_ds_get_predicate_value        201      445     244  +121.39
acpi_rs_address64_resource         351      445      94   +26.78
acpi_ev_detach_region              166      449     283  +170.48
acpi_ec_add                        326      451     125   +38.34
acpi_ex_store_object_to_node       162      451     289  +178.40
acpi_get_object_info               446      461      15    +3.36
acpi_ds_parse_method               231      462     231  +100.00
acpi_ns_init_one_device            178      462     284  +159.55
acpi_ut_divide                     385      464      79   +20.52
acpi_pci_link_add                  368      466      98   +26.63
acpi_hw_set_mode                   256      468     212   +82.81
acpi_system_alarm_seq_show         434      477      43    +9.91
acpi_ds_exec_begin_op              274      478     204   +74.45
acpi_tb_get_this_table             297      484     187   +62.96
acpi_ev_gpe_dispatch               299      488     189   +63.21
acpi_ps_get_next_arg               382      492     110   +28.80
acpi_ex_write_with_update_rule     242      495     253  +104.55
acpi_bus_add                       366      496     130   +35.52
acpi_ns_search_and_enter           257      499     242   +94.16
acpi_rs_dump_address32           (new)      502     502
acpi_ex_load_table_op              339      503     164   +48.38
acpi_rs_dump_address16           (new)      513     513
acpi_ex_convert_to_string          349      514     165   +47.28
acpi_ex_release_mutex              341      515     174   +51.03
acpi_rs_dump_address64           (new)      518     518
acpi_ex_opcode_6A_0T_1R            404      519     115   +28.47
acpi_ps_complete_this_op           369      520     151   +40.92
acpi_ex_do_logical_op              462      523      61   +13.20
acpi_ev_create_gpe_info_blocks     356      524     168   +47.19
acpi_ev_create_gpe_block           256      535     279  +108.98
acpi_ds_get_field_names            346      537     191   +55.20
acpi_get_sleep_type_data           329      538     209   +63.53
acpi_pci_irq_add_prt               352      542     190   +53.98
acpi_install_notify_handler        447      543      96   +21.48
acpi_ex_read_data_from_field       341      547     206   +60.41
acpi_ev_gpe_initialize             407      548     141   +34.64
acpi_ev_initialize_region          303      550     247   +81.52
acpi_ds_store_object_to_local      289      554     265   +91.70
acpi_ps_get_next_namepath          375      554     179   +47.73
acpi_ds_is_result_used             245      557     312  +127.35
acpi_ex_do_concatenate             494      559      65   +13.16
acpi_ex_resolve_multiple           317      559     242   +76.34
acpi_ut_strtoul64                  442      559     117   +26.47
acpi_pci_irq_enable                347      560     213   +61.38
acpi_ds_init_buffer_field          354      562     208   +58.76
acpi_ns_externalize_name           449      572     123   +27.39
acpi_ds_init_object_from_op        423      575     152   +35.93
acpi_ex_resolve_object_to_valu     417      585     168   +40.29
acpi_ds_exec_end_control_op        388      592     204   +52.58
acpi_tb_find_rsdp                  315      604     289   +91.75
acpi_rs_get_list_length            532      611      79   +14.85
acpi_bus_set_power                 321      613     292   +90.97
acpi_remove_notify_handler         445      615     170   +38.20
acpi_ex_get_name_string            401      617     216   +53.87
acpi_rs_byte_stream_to_list        522      621      99   +18.97
acpi_ps_parse_aml                  426      625     199   +46.71
acpi_ut_delete_internal_obj        245      625     380  +155.10
acpi_ds_load1_begin_op             401      627     226   +56.36
acpi_psx_execute                   426      631     205   +48.12
acpi_evaluate_object               442      635     193   +43.67
acpi_ev_pci_config_region_setu     479      638     159   +33.19
acpi_ev_install_space_handler      502      644     142   +28.29
acpi_set_register                  351      667     316   +90.03
acpi_ds_call_control_method        432      677     245   +56.71
acpi_tb_get_required_tables        441      678     237   +53.74
acpi_ex_insert_into_field          552      684     132   +23.91
acpi_pci_link_set                  387      684     297   +76.74
acpi_ev_address_space_dispatch     296      689     393  +132.77
acpi_ex_field_datum_io             418      689     271   +64.83
acpi_ut_init_globals               563      701     138   +24.51
acpi_ex_extract_from_field         621      724     103   +16.59
acpi_leave_sleep_state             645      742      97   +15.04
acpi_ut_update_object_referenc     605      742     137   +22.64
acpi_ex_system_memory_space_ha     544      744     200   +36.76
acpi_ex_resolve_node_to_value      239      760     521  +217.99
acpi_ds_create_operand             418      763     345   +82.54
acpi_enter_sleep_state             460      766     306   +66.52
acpi_ex_load_op                    496      776     280   +56.45
acpi_pci_root_add                  520      776     256   +49.23
acpi_ns_root_initialize            614      778     164   +26.71
acpi_ex_prep_field_value           388      781     393  +101.29
acpi_ds_load2_begin_op             560      782     222   +39.64
acpi_pci_bind                      408      793     385   +94.36
acpi_evaluate_reference            188      836     648  +344.68
acpi_ex_opcode_2A_1T_1R            714      841     127   +17.79
acpi_ds_load2_end_op               588      870     282   +47.96
acpi_ex_store                      277      876     599  +216.25
acpi_rs_create_pci_routing_tab     408      887     479  +117.40
acpi_ex_write_data_to_field        542      918     376   +69.37
acpi_extract_package               610      949     339   +55.57
acpi_get_firmware_table            723      980     257   +35.55
acpi_ex_dump_operand             (new)     1014    1014
acpi_ds_exec_end_op                682     1152     470   +68.91
acpi_ex_opcode_1A_0T_1R            963     1215     252   +26.17
acpi_system_write_alarm           1121     1243     122   +10.88
acpi_ns_dump_one_object          (new)     1292    1292
acpi_ns_lookup                     784     1318     534   +68.11
acpi_ex_dump_object_descriptor   (new)     1529    1529
acpi_ex_opcode_1A_1T_1R           1476     1666     190   +12.87
acpi_ex_resolve_operands           774     1763     989  +127.78
acpi_ps_parse_loop                2145     2664     519   +24.20





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
