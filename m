From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: acpi_memhotplug.c having a bit of trouble any thoughts?
Date: Mon, 09 May 2005 19:20:49 -0700
Message-ID: <1115691649.5109.75.camel@knk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mVhJryNovFlaK2oIp2aG"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, metolent-T1wkCzuAVFtlwyM8M8X0TNh3ngVCH38I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-mVhJryNovFlaK2oIp2aG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,
  Well after banging my head around the acpi code a for longer than I
would like to admit in the linux-2.6.12-rc1-mph3 tree (no
acpi_memhotplug.c driver, there started hacking something in the tree
for my specific hot-add memory event :( ) I moved to
linux-2.6.12-rc3-mph1 (yeaaa! acpi_memhotplug.c. Don't ask why it took
so long to move, I don't know :))

  Anyway I am using an IBM x445 with to do hot add memory in i386
(pre-acpi 2.0 support in the bios).  When I do the hot add event (see
attached acpi debug output) things go along just fine until
acpi_bus_get_device in acpi_memory_get_device.  

I get a
driver data not foundacpi_memory-0159 [005A] [03] acpi_memory_get_device: ----Exit- FFFFFFFFFFFFFFED
acpi_memory-0310 [005A] [02] acpi_memory_device_not: Error in finding driver data
(plus a mess of other stuff)

The actual data of the event either got dropped or was not associated to
the device correctly. Any thoughts as to where I could start?  ACPI and
me are not getting along to well :(

Thanks,
  Keith Mannthey 
  LTC xSeries

--=-mVhJryNovFlaK2oIp2aG
Content-Disposition: attachment; filename=tmp
Content-Type: text/plain; name=tmp; charset=
Content-Transfer-Encoding: 7bit

oc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c12ad328 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj f5428428 Refs=1, [Decremented]
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
dsmthdat-0155 [005A] [16] ds_method_data_delete_: Deleting Arg1=c12ad928
nsobject-0212 [005A] [17] ns_detach_object      : ----Entry
nsobject-0238 [005A] [17] ns_detach_object      : Node ef60a470 [__A1] Object c12ad928
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c12ad928
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c12ad928 Current Refs=1 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c12ad928
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c12ad928
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c12ad300
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c12ad300
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c12ad328
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c12ad328
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c12ad328 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c12ad928 Refs=0, [Decremented]
utdelete-0078 [005A] [20] ut_delete_internal_obj: ----Entry c12ad928
utdelete-0239 [005A] [20] ut_delete_internal_obj: Deleting Object c12ad928 [Integer]
utobject-0353 [005A] [21] ut_delete_object_desc : ----Entry c12ad928
 utalloc-0596 [005A] [22] ut_free               : ----Entry c12ad928
 utalloc-0788 [005A] [23] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [23] ut_remove_allocation  : Freeing size 028
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [23] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [22] ut_free               : c12ad928 freed
 utalloc-0623 [005A] [22] ut_free               : ----Exit-
utobject-0367 [005A] [21] ut_delete_object_desc : ----Exit-
utdelete-0242 [005A] [20] ut_delete_internal_obj: ----Exit-
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
dsmthdat-0155 [005A] [16] ds_method_data_delete_: Deleting Arg2=f5428328
nsobject-0212 [005A] [17] ns_detach_object      : ----Entry
nsobject-0238 [005A] [17] ns_detach_object      : Node ef60a488 [__A2] Object f5428328
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry f5428328
utdelete-0689 [005A] [18] ut_remove_reference   : Obj f5428328 Current Refs=2 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry f5428328
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry f5428328
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c12ad900
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c12ad900
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c12ad928
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c12ad928
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c12ad928 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj f5428328 Refs=1, [Decremented]
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
dsmthdat-0155 [005A] [16] ds_method_data_delete_: Deleting Arg3=c123d7a8
nsobject-0212 [005A] [17] ns_detach_object      : ----Entry
nsobject-0238 [005A] [17] ns_detach_object      : Node ef60a4a0 [__A3] Object c123d7a8
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c123d7a8
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c123d7a8 Current Refs=1 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c123d7a8
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c123d7a8
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c12ad900
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c12ad900
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c12ad928
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c12ad928
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c12ad928 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c123d7a8 Refs=0, [Decremented]
utdelete-0078 [005A] [20] ut_delete_internal_obj: ----Entry c123d7a8
utdelete-0239 [005A] [20] ut_delete_internal_obj: Deleting Object c123d7a8 [Integer]
utobject-0353 [005A] [21] ut_delete_object_desc : ----Entry c123d7a8
 utalloc-0596 [005A] [22] ut_free               : ----Entry c123d7a8
 utalloc-0788 [005A] [23] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [23] ut_remove_allocation  : Freeing size 028
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [23] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [22] ut_free               : c123d7a8 freed
 utalloc-0623 [005A] [22] ut_free               : ----Exit-
utobject-0367 [005A] [21] ut_delete_object_desc : ----Exit-
utdelete-0242 [005A] [20] ut_delete_internal_obj: ----Exit-
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
dsmthdat-0155 [005A] [16] ds_method_data_delete_: Deleting Arg4=c123d828
nsobject-0212 [005A] [17] ns_detach_object      : ----Entry
nsobject-0238 [005A] [17] ns_detach_object      : Node ef60a4b8 [__A4] Object c123d828
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c123d828
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c123d828 Current Refs=1 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c123d828
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c123d828
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c123d780
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c123d780
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c123d7a8
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c123d7a8
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c123d7a8 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c123d828 Refs=0, [Decremented]
utdelete-0078 [005A] [20] ut_delete_internal_obj: ----Entry c123d828
utdelete-0239 [005A] [20] ut_delete_internal_obj: Deleting Object c123d828 [Integer]
utobject-0353 [005A] [21] ut_delete_object_desc : ----Entry c123d828
 utalloc-0596 [005A] [22] ut_free               : ----Entry c123d828
 utalloc-0788 [005A] [23] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [23] ut_remove_allocation  : Freeing size 028
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [23] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [22] ut_free               : c123d828 freed
 utalloc-0623 [005A] [22] ut_free               : ----Exit-
utobject-0367 [005A] [21] ut_delete_object_desc : ----Exit-
utdelete-0242 [005A] [20] ut_delete_internal_obj: ----Exit-
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
dsmthdat-0163 [005A] [16] ds_method_data_delete_: ----Exit-
  utmisc-0737 [005A] [15] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Parser]
     osl-0898 [005A] [16] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [16] os_wait_semaphore     : Waiting for semaphore[c11fe860|1|65535]
     osl-0961 [005A] [16] os_wait_semaphore     : Acquired semaphore[c11fe860|1|65535]
     osl-0964 [005A] [16] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [15] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Parser]
  utmisc-0737 [005A] [15] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Namespace]
     osl-0898 [005A] [16] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [16] os_wait_semaphore     : Waiting for semaphore[c11fe7e0|1|65535]
     osl-0961 [005A] [16] os_wait_semaphore     : Acquired semaphore[c11fe7e0|1|65535]
     osl-0964 [005A] [16] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [15] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Namespace]
 nsalloc-0476 [005A] [16] ns_delete_namespace_su: ----Entry
nsobject-0212 [005A] [17] ns_detach_object      : ----Entry
nsobject-0238 [005A] [17] ns_detach_object      : Node c1217f28 [RETR] Object c1239f28
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c1239f28
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c1239f28 Current Refs=2 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c123d800
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c123d800
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c123d828
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c123d828
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c123d828 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c1239f28 Refs=1, [Decremented]
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
 nsalloc-0378 [005A] [17] ns_delete_children    : ----Entry c11fc7e8
 nsalloc-0413 [005A] [17] ns_delete_children    : Object c1217f28, Remaining 0
nsobject-0212 [005A] [18] ns_detach_object      : ----Entry
nsobject-0219 [005A] [18] ns_detach_object      : ----Exit-
 utalloc-0596 [005A] [18] ut_free               : ----Entry c1217f28
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 018
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c1217f28 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
 nsalloc-0451 [005A] [17] ns_delete_children    : ----Exit-
 nsalloc-0532 [005A] [16] ns_delete_namespace_su: ----Exit-
 nsalloc-0614 [005A] [16] ns_delete_namespace_by: ----Entry 00000365
 nsalloc-0682 [005A] [16] ns_delete_namespace_by: ----Exit-
  utmisc-0785 [005A] [15] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Namespace]
     osl-0979 [005A] [16] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [16] os_signal_semaphore   : Signaling semaphore[c11fe7e0|1]
     osl-0991 [005A] [16] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [15] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Namespace]
  utmisc-0785 [005A] [15] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Parser]
     osl-0979 [005A] [16] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [16] os_signal_semaphore   : Signaling semaphore[c11fe860|1]
     osl-0991 [005A] [16] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [15] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Parser]
dsmethod-0594 [005A] [15] ds_terminate_control_m: ----Exit- AE_OK
 psscope-0274 [005A] [15] ps_cleanup_scope      : ----Entry ef60a618
  utmisc-0970 [005A] [16] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [16] ut_pop_generic_state  : ----Exit- c123dba8
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c123dba8
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c123dba8 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
 psscope-0288 [005A] [15] ps_cleanup_scope      : ----Exit-
 psparse-1191 [005A] [14] ps_parse_aml          : return_value=c1239f28, implicit_value=00000000 State=ef60a428
dswstate-0749 [005A] [14] ds_get_current_walk_st: Current walk_state ef245c28
dsmethod-0418 [005A] [15] ds_restart_control_met: ----Entry ef245c28
dsmethod-0424 [005A] [15] ds_restart_control_met: ****Restart [_CRS] Op c1239228 return_value_from_callee c1239f28
dsmethod-0429 [005A] [15] ds_restart_control_met:     return_from_this_method_used?=1 res_stack c123d6a8 Walk ef245c28
dswstate-0357 [005A] [15] ds_result_push        : Obj=c1239f28 [Buffer] State=ef245c28 Num=1 Cur=0
dsmethod-0469 [005A] [15] ds_restart_control_met: ----Exit- AE_OK
dswstate-1026 [005A] [15] ds_delete_walk_state  : ----Entry ef60a428
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c1239b28
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c1239b28 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c12393a8
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c12393a8 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c123d228
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c123d228 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
 utalloc-0596 [005A] [16] ut_free               : ----Entry ef60a428
 utalloc-0788 [005A] [17] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [17] ut_remove_allocation  : Freeing size 0240
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [17] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [16] ut_free               : ef60a428 freed
 utalloc-0623 [005A] [16] ut_free               : ----Exit-
dswstate-1070 [005A] [15] ds_delete_walk_state  : ----Exit-
 psparse-0436 [005A] [15] ps_parse_loop         : ----Entry ef245c28
 psscope-0221 [005A] [16] ps_pop_scope          : ----Entry
  utmisc-0970 [005A] [17] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [17] ut_pop_generic_state  : ----Exit- c12ad8a8
  utmisc-1204 [005A] [17] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [18] ut_free               : ----Entry c12ad8a8
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c12ad8a8 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
  utmisc-1208 [005A] [17] ut_delete_generic_stat: ----Exit-
 psscope-0249 [005A] [16] ps_pop_scope          : Popped Op c123dd28 Args 0
 psscope-0250 [005A] [16] ps_pop_scope          : ----Exit-
 psparse-0484 [005A] [15] ps_parse_loop         : Popped scope, Op=c123dd28
  psargs-0611 [005A] [16] ps_get_next_arg       : ----Entry ef245e18
  psargs-0745 [005A] [16] ps_get_next_arg       : ----Exit- AE_OK
 psscope-0162 [005A] [16] ps_push_scope         : ----Entry c123dd28
 utalloc-0434 [005A] [17] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [17] ut_callocate          : ----Exit- c12ad880
 utalloc-0704 [005A] [17] ut_track_allocation   : ----Entry c12ad880
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [17] ut_track_allocation   : ----Exit- AE_OK
  utmisc-0939 [005A] [17] ut_push_generic_state : ----Entry
  utmisc-0947 [005A] [17] ut_push_generic_state : ----Exit-
 psscope-0191 [005A] [16] ps_push_scope         : ----Exit- AE_OK
 utalloc-0434 [005A] [16] ut_callocate          : ----Entry 00000044
 utalloc-0457 [005A] [16] ut_callocate          : ----Exit- c123d200
 utalloc-0704 [005A] [16] ut_track_allocation   : ----Entry c123d200
  utmisc-0737 [005A] [16] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [17] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [17] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [17] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [17] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [16] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [16] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [17] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [17] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [17] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [16] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [16] ut_track_allocation   : ----Exit- AE_OK
 dswexec-0220 [005A] [16] ds_exec_begin_op      : ----Entry ef245c28
 dswexec-0332 [005A] [16] ds_exec_begin_op      : ----Exit- AE_OK
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c123d228
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- AE_OK
 psparse-0686 [005A] [15] ps_parse_loop         : Opcode 0060 [Local0] Op c123d228 Aml f8808875 aml_offset 0001F
 dswexec-0364 [005A] [16] ds_exec_end_op        : ----Entry ef245c28
 dswexec-0748 [005A] [16] ds_exec_end_op        : ----Exit- AE_OK
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c123d228
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- AE_OK
 psparse-0156 [005A] [16] ps_complete_this_op   : ----Entry c123d228
 psparse-0169 [005A] [16] ps_complete_this_op   : ----Exit-
 psscope-0221 [005A] [16] ps_pop_scope          : ----Entry
  utmisc-0970 [005A] [17] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [17] ut_pop_generic_state  : ----Exit- c12ad8a8
  utmisc-1204 [005A] [17] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [18] ut_free               : ----Entry c12ad8a8
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c12ad8a8 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
  utmisc-1208 [005A] [17] ut_delete_generic_stat: ----Exit-
 psscope-0249 [005A] [16] ps_pop_scope          : Popped Op c123dd28 Args 0
 psscope-0250 [005A] [16] ps_pop_scope          : ----Exit-
 psparse-0985 [005A] [15] ps_parse_loop         : Popped scope, Op=c123dd28
 dswexec-0364 [005A] [16] ds_exec_end_op        : ----Entry ef245c28
 dsutils-0707 [005A] [17] ds_create_operands    : ----Entry c123d128
 dsutils-0493 [005A] [18] ds_create_operand     : ----Entry c123d128
 dsutils-0630 [005A] [18] ds_create_operand     : Argument previously created, already stacked 
dswstate-0303 [005A] [18] ds_result_pop_from_bot: Obj=c1239f28 [Buffer], Results=c123d6a8 State=ef245c28
dswstate-0514 [005A] [18] ds_obj_stack_push     : Obj=c1239f28 [Buffer] State=ef245c28 #Ops=1
 dsutils-0678 [005A] [18] ds_create_operand     : ----Exit- AE_OK
 dsutils-0720 [005A] [17] ds_create_operands    : Arg #0 (c123d128) done, Arg1=c123d128
 dsutils-0493 [005A] [18] ds_create_operand     : ----Entry c123d228
utobject-0086 [005A] [19] ut_create_internal_obj: ----Entry Reference
utobject-0315 [005A] [20] ut_allocate_object_des: ----Entry
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000050
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c12ad880
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c12ad880
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
utobject-0331 [005A] [20] ut_allocate_object_des: c12ad8a8 Size 28
utobject-0333 [005A] [20] ut_allocate_object_des: ----Exit- c12ad8a8
utobject-0131 [005A] [19] ut_create_internal_obj: ----Exit- c12ad8a8
dsobject-0446 [005A] [19] ds_init_object_from_op: ----Entry
dsmthdat-0242 [005A] [20] ds_method_data_get_nod: ----Entry
dsmthdat-0280 [005A] [20] ds_method_data_get_nod: ----Exit- AE_OK
dsobject-0615 [005A] [19] ds_init_object_from_op: ----Exit- AE_OK
dswstate-0514 [005A] [18] ds_obj_stack_push     : Obj=c12ad8a8 [Reference] State=ef245c28 #Ops=2
 dsutils-0678 [005A] [18] ds_create_operand     : ----Exit- AE_OK
 dsutils-0720 [005A] [17] ds_create_operands    : Arg #1 (c123d228) done, Arg1=c123d128
 dsutils-0728 [005A] [17] ds_create_operands    : ----Exit- AE_OK
  utmisc-0970 [005A] [17] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [17] ut_pop_generic_state  : ----Exit- c123d6a8
dswstate-0432 [005A] [16] ds_result_stack_pop   : Result=c123d6a8 remaining_results=0 State=ef245c28
  utmisc-1204 [005A] [17] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [18] ut_free               : ----Entry c123d6a8
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c123d6a8 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
  utmisc-1208 [005A] [17] ut_delete_generic_stat: ----Exit-
 exresop-0147 [005A] [17] ex_resolve_operands   : ----Entry 00000070
 exresop-0164 [005A] [17] ex_resolve_operands   : Opcode 70 [Store] required_operand_types=000002CF 
 exresop-0231 [005A] [17] ex_resolve_operands   : Operand is a Reference, ref_opcode [Local0]
exresolv-0081 [005A] [18] ex_resolve_to_value   : ----Entry ef245de8
exresolv-0146 [005A] [19] ex_resolve_object_to_v: ----Entry
dsopcode-0232 [005A] [20] ds_get_buffer_argument: ----Entry c1239f28
dsopcode-0236 [005A] [20] ds_get_buffer_argument: ----Exit- AE_OK
exresolv-0300 [005A] [19] ex_resolve_object_to_v: ----Exit- AE_OK
exresolv-0114 [005A] [18] ex_resolve_to_value   : Resolved object c1239f28
exresolv-0115 [005A] [18] ex_resolve_to_value   : ----Exit- AE_OK
 exresop-0658 [005A] [17] ex_resolve_operands   : ----Exit- AE_OK
  exdump-0424 [005A] [16] ex_dump_operands      : ************* Operand Stack Contents (Opcode [Store], 2 Operands)
  exdump-0117 [005A] [16] ex_dump_operand       : c12ad8a8 Reference: Local0
  exdump-0117 [005A] [16] ex_dump_operand       : c1239f28 Buffer len 5E @ f55adda8 
Buffer Contents:  8a 2b 00 00 0c 01 00 00 00 00 00 00 00 00 00 00 00 c0 01 00 00 00 ff ff ff 3f 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 00 8a 2b 00 00 0c 01 00 00 00 00 00 00 00 00 00 00 00 40
  exdump-0438 [005A] [16] ex_dump_operands      : ************* Stack dump from dswexec(425), after ex_resolve_operands
exoparg1-0292 [005A] [17] ex_opcode_1A_1T_1R    : ----Entry Store
 exstore-0087 [005A] [18] ex_store              : ----Entry c12ad8a8
dsmthdat-0590 [005A] [19] ds_store_object_to_loc: ----Entry
dsmthdat-0592 [005A] [19] ds_store_object_to_loc: Opcode=60 Index=0 Obj=c1239f28
dsmthdat-0242 [005A] [20] ds_method_data_get_nod: ----Entry
dsmthdat-0280 [005A] [20] ds_method_data_get_nod: ----Exit- AE_OK
nsobject-0264 [005A] [20] ns_get_attached_object: ----Entry ef245d14
nsobject-0276 [005A] [20] ns_get_attached_object: ----Exit- 00000000
dsmthdat-0311 [005A] [20] ds_method_data_set_val: ----Entry
dsmthdat-0317 [005A] [20] ds_method_data_set_val: new_obj c1239f28 Opcode 60, Refs=1 [Buffer]
dsmthdat-0242 [005A] [21] ds_method_data_get_nod: ----Entry
dsmthdat-0280 [005A] [21] ds_method_data_get_nod: ----Exit- AE_OK
utdelete-0631 [005A] [21] ut_add_reference      : ----Entry c1239f28
utdelete-0642 [005A] [21] ut_add_reference      : Obj c1239f28 Current Refs=1 [To Be Incremented]
utdelete-0422 [005A] [22] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [23] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [24] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [24] ut_callocate          : ----Exit- c123d680
 utalloc-0704 [005A] [24] ut_track_allocation   : ----Entry c123d680
  utmisc-0737 [005A] [24] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [25] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [25] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [25] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [25] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [24] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [24] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [25] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [25] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [25] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [24] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [24] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [23] ut_create_update_state: ----Exit- c123d6a8
  utmisc-1204 [005A] [23] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [24] ut_free               : ----Entry c123d6a8
 utalloc-0788 [005A] [25] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [25] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [26] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [26] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [26] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [26] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [25] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [25] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [25] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [26] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [26] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [26] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [25] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [25] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [24] ut_free               : c123d6a8 freed
 utalloc-0623 [005A] [24] ut_free               : ----Exit-
  utmisc-1208 [005A] [23] ut_delete_generic_stat: ----Exit-
utdelete-0325 [005A] [22] ut_update_ref_count   : Obj c1239f28 Refs=2, [Incremented]
  utmisc-0970 [005A] [23] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [23] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [22] ut_update_object_refer: ----Exit- AE_OK
utdelete-0647 [005A] [21] ut_add_reference      : ----Exit-
dsmthdat-0337 [005A] [20] ds_method_data_set_val: ----Exit- AE_OK
dsmthdat-0712 [005A] [19] ds_store_object_to_loc: ----Exit- AE_OK
 exstore-0257 [005A] [18] ex_store              : ----Exit- AE_OK
exoparg1-0493 [005A] [17] ex_opcode_1A_1T_1R    : ----Exit- AE_OK
 dsutils-0440 [005A] [17] ds_clear_operands     : ----Entry ef245c28
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry 00000000
utdelete-0678 [005A] [18] ut_remove_reference   : ----Exit-
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c12ad8a8
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c12ad8a8 Current Refs=1 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c12ad8a8
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c12ad8a8
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c123d680
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c123d680
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c123d6a8
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c123d6a8
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c123d6a8 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c12ad8a8 Refs=0, [Decremented]
utdelete-0078 [005A] [20] ut_delete_internal_obj: ----Entry c12ad8a8
utdelete-0239 [005A] [20] ut_delete_internal_obj: Deleting Object c12ad8a8 [Reference]
utobject-0353 [005A] [21] ut_delete_object_desc : ----Entry c12ad8a8
 utalloc-0596 [005A] [22] ut_free               : ----Entry c12ad8a8
 utalloc-0788 [005A] [23] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [23] ut_remove_allocation  : Freeing size 028
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [23] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [22] ut_free               : c12ad8a8 freed
 utalloc-0623 [005A] [22] ut_free               : ----Exit-
utobject-0367 [005A] [21] ut_delete_object_desc : ----Exit-
utdelete-0242 [005A] [20] ut_delete_internal_obj: ----Exit-
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
 dsutils-0455 [005A] [17] ds_clear_operands     : ----Exit-
dswstate-0357 [005A] [16] ds_result_push        : Obj=c1239f28 [Buffer] State=ef245c28 Num=1 Cur=0
 dsutils-0355 [005A] [17] ds_delete_result_if_no: ----Entry c1239f28
 dsutils-0189 [005A] [18] ds_is_result_used     : ----Entry c123dd28
 dsutils-0143 [005A] [18] ds_do_implicit_return : Result c1239f28 will be implicitly returned; Prev=00000000
utdelete-0631 [005A] [19] ut_add_reference      : ----Entry c1239f28
utdelete-0642 [005A] [19] ut_add_reference      : Obj c1239f28 Current Refs=2 [To Be Incremented]
utdelete-0422 [005A] [20] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [21] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [22] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [22] ut_callocate          : ----Exit- c12ad880
 utalloc-0704 [005A] [22] ut_track_allocation   : ----Entry c12ad880
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [22] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [21] ut_create_update_state: ----Exit- c12ad8a8
  utmisc-1204 [005A] [21] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [22] ut_free               : ----Entry c12ad8a8
 utalloc-0788 [005A] [23] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [23] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [23] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [22] ut_free               : c12ad8a8 freed
 utalloc-0623 [005A] [22] ut_free               : ----Exit-
  utmisc-1208 [005A] [21] ut_delete_generic_stat: ----Exit-
utdelete-0325 [005A] [20] ut_update_ref_count   : Obj c1239f28 Refs=3, [Incremented]
  utmisc-0970 [005A] [21] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [21] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [20] ut_update_object_refer: ----Exit- AE_OK
utdelete-0647 [005A] [19] ut_add_reference      : ----Exit-
 dsutils-0223 [005A] [18] ds_is_result_used     : At Method level, result of [Store] not used
 dsutils-0224 [005A] [18] ds_is_result_used     : ----Exit- 0000000000000000
dswstate-0232 [005A] [17] ds_result_pop         : Obj=c1239f28 [Buffer] Index=0 State=ef245c28 Num=0
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c1239f28
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c1239f28 Current Refs=3 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c12ad880
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c12ad880
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c12ad8a8
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c12ad8a8
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c12ad8a8 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c1239f28 Refs=2, [Decremented]
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
 dsutils-0376 [005A] [17] ds_delete_result_if_no: ----Exit-
 dswexec-0748 [005A] [16] ds_exec_end_op        : ----Exit- AE_OK
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c123dd28
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- AE_OK
 psparse-0156 [005A] [16] ps_complete_this_op   : ----Entry c123dd28
  pswalk-0073 [005A] [17] ps_delete_parse_tree  : ----Entry c123dd28
 psutils-0199 [005A] [17] ps_free_op            : Free retval op: c123d128
 utalloc-0596 [005A] [18] ut_free               : ----Entry c123d128
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 01C
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c123d128 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
 utalloc-0596 [005A] [18] ut_free               : ----Entry c123d228
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 01C
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c123d228 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
 utalloc-0596 [005A] [18] ut_free               : ----Entry c123dd28
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 01C
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c123dd28 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
  pswalk-0105 [005A] [17] ps_delete_parse_tree  : ----Exit-
 psparse-0286 [005A] [16] ps_complete_this_op   : ----Exit-
 utalloc-0434 [005A] [16] ut_callocate          : ----Entry 00000044
 utalloc-0457 [005A] [16] ut_callocate          : ----Exit- c123dd00
 utalloc-0704 [005A] [16] ut_track_allocation   : ----Entry c123dd00
  utmisc-0737 [005A] [16] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [17] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [17] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [17] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [17] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [16] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [16] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [17] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [17] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [17] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [16] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [16] ut_track_allocation   : ----Exit- AE_OK
 dswexec-0220 [005A] [16] ds_exec_begin_op      : ----Entry ef245c28
 utalloc-0434 [005A] [17] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [17] ut_callocate          : ----Exit- c123d200
 utalloc-0704 [005A] [17] ut_track_allocation   : ----Entry c123d200
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [17] ut_track_allocation   : ----Exit- AE_OK
  utmisc-0939 [005A] [17] ut_push_generic_state : ----Entry
  utmisc-0947 [005A] [17] ut_push_generic_state : ----Exit-
dswstate-0393 [005A] [16] ds_result_stack_push  : Results=c123d228 State=ef245c28
dsopcode-0876 [005A] [16] ds_exec_begin_control_: Op=c123dd28 Opcode=A4 State=ef245c28
 dswexec-0332 [005A] [16] ds_exec_begin_op      : ----Exit- AE_OK
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c123dd28
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- AE_OK
 psparse-0686 [005A] [15] ps_parse_loop         : Opcode 00A4 [Return] Op c123dd28 Aml f8808876 aml_offset 00020
  psargs-0611 [005A] [16] ps_get_next_arg       : ----Entry ef245e18
  psargs-0745 [005A] [16] ps_get_next_arg       : ----Exit- AE_OK
 psscope-0162 [005A] [16] ps_push_scope         : ----Entry c123dd28
 utalloc-0434 [005A] [17] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [17] ut_callocate          : ----Exit- c123d100
 utalloc-0704 [005A] [17] ut_track_allocation   : ----Entry c123d100
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [17] ut_track_allocation   : ----Exit- AE_OK
  utmisc-0939 [005A] [17] ut_push_generic_state : ----Entry
  utmisc-0947 [005A] [17] ut_push_generic_state : ----Exit-
 psscope-0191 [005A] [16] ps_push_scope         : ----Exit- AE_OK
 utalloc-0434 [005A] [16] ut_callocate          : ----Entry 00000044
 utalloc-0457 [005A] [16] ut_callocate          : ----Exit- c12ad880
 utalloc-0704 [005A] [16] ut_track_allocation   : ----Entry c12ad880
  utmisc-0737 [005A] [16] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [17] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [17] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [17] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [17] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [16] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [16] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [17] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [17] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [17] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [16] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [16] ut_track_allocation   : ----Exit- AE_OK
 dswexec-0220 [005A] [16] ds_exec_begin_op      : ----Entry ef245c28
 dswexec-0332 [005A] [16] ds_exec_begin_op      : ----Exit- AE_OK
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c12ad8a8
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- AE_OK
 psparse-0686 [005A] [15] ps_parse_loop         : Opcode 0060 [Local0] Op c12ad8a8 Aml f8808877 aml_offset 00021
 dswexec-0364 [005A] [16] ds_exec_end_op        : ----Entry ef245c28
 dswexec-0748 [005A] [16] ds_exec_end_op        : ----Exit- AE_OK
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c12ad8a8
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- AE_OK
 psparse-0156 [005A] [16] ps_complete_this_op   : ----Entry c12ad8a8
 psparse-0169 [005A] [16] ps_complete_this_op   : ----Exit-
 psscope-0221 [005A] [16] ps_pop_scope          : ----Entry
  utmisc-0970 [005A] [17] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [17] ut_pop_generic_state  : ----Exit- c123d128
  utmisc-1204 [005A] [17] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [18] ut_free               : ----Entry c123d128
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c123d128 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
  utmisc-1208 [005A] [17] ut_delete_generic_stat: ----Exit-
 psscope-0249 [005A] [16] ps_pop_scope          : Popped Op c123dd28 Args 0
 psscope-0250 [005A] [16] ps_pop_scope          : ----Exit-
 psparse-0985 [005A] [15] ps_parse_loop         : Popped scope, Op=c123dd28
 dswexec-0364 [005A] [16] ds_exec_end_op        : ----Entry ef245c28
dsopcode-1005 [005A] [16] ds_exec_end_control_op: [RETURN_OP] Op=c123dd28 Arg=c12ad8a8
 dsutils-0094 [005A] [16] ds_clear_implicit_retu: Removing reference on stale implicit return obj c1239f28
utdelete-0668 [005A] [17] ut_remove_reference   : ----Entry c1239f28
utdelete-0689 [005A] [17] ut_remove_reference   : Obj c1239f28 Current Refs=2 [To Be Decremented]
utdelete-0422 [005A] [18] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [19] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [20] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [20] ut_callocate          : ----Exit- c123d100
 utalloc-0704 [005A] [20] ut_track_allocation   : ----Entry c123d100
  utmisc-0737 [005A] [20] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [21] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [21] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [21] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [21] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [20] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [20] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [21] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [21] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [21] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [20] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [20] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [19] ut_create_update_state: ----Exit- c123d128
  utmisc-1204 [005A] [19] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [20] ut_free               : ----Entry c123d128
 utalloc-0788 [005A] [21] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [21] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [21] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [20] ut_free               : c123d128 freed
 utalloc-0623 [005A] [20] ut_free               : ----Exit-
  utmisc-1208 [005A] [19] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [18] ut_update_ref_count   : Obj c1239f28 Refs=1, [Decremented]
  utmisc-0970 [005A] [19] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [19] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [18] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [17] ut_remove_reference   : ----Exit-
 dsutils-0707 [005A] [17] ds_create_operands    : ----Entry c12ad8a8
 dsutils-0493 [005A] [18] ds_create_operand     : ----Entry c12ad8a8
utobject-0086 [005A] [19] ut_create_internal_obj: ----Entry Reference
utobject-0315 [005A] [20] ut_allocate_object_des: ----Entry
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000050
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c123d100
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c123d100
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
utobject-0331 [005A] [20] ut_allocate_object_des: c123d128 Size 28
utobject-0333 [005A] [20] ut_allocate_object_des: ----Exit- c123d128
utobject-0131 [005A] [19] ut_create_internal_obj: ----Exit- c123d128
dsobject-0446 [005A] [19] ds_init_object_from_op: ----Entry
dsmthdat-0242 [005A] [20] ds_method_data_get_nod: ----Entry
dsmthdat-0280 [005A] [20] ds_method_data_get_nod: ----Exit- AE_OK
dsobject-0615 [005A] [19] ds_init_object_from_op: ----Exit- AE_OK
dswstate-0514 [005A] [18] ds_obj_stack_push     : Obj=c123d128 [Reference] State=ef245c28 #Ops=1
 dsutils-0678 [005A] [18] ds_create_operand     : ----Exit- AE_OK
 dsutils-0720 [005A] [17] ds_create_operands    : Arg #0 (c12ad8a8) done, Arg1=c12ad8a8
 dsutils-0728 [005A] [17] ds_create_operands    : ----Exit- AE_OK
exresolv-0081 [005A] [17] ex_resolve_to_value   : ----Entry ef245de8
exresolv-0146 [005A] [18] ex_resolve_object_to_v: ----Entry
dsmthdat-0421 [005A] [19] ds_method_data_get_val: ----Entry
dsmthdat-0242 [005A] [20] ds_method_data_get_nod: ----Entry
dsmthdat-0280 [005A] [20] ds_method_data_get_nod: ----Exit- AE_OK
utdelete-0631 [005A] [20] ut_add_reference      : ----Entry c1239f28
utdelete-0642 [005A] [20] ut_add_reference      : Obj c1239f28 Current Refs=1 [To Be Incremented]
utdelete-0422 [005A] [21] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [22] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [23] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [23] ut_callocate          : ----Exit- c123d680
 utalloc-0704 [005A] [23] ut_track_allocation   : ----Entry c123d680
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [23] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [22] ut_create_update_state: ----Exit- c123d6a8
  utmisc-1204 [005A] [22] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [23] ut_free               : ----Entry c123d6a8
 utalloc-0788 [005A] [24] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [24] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [25] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [25] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [25] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [25] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [24] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [24] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [24] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [25] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [25] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [25] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [24] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [24] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [23] ut_free               : c123d6a8 freed
 utalloc-0623 [005A] [23] ut_free               : ----Exit-
  utmisc-1208 [005A] [22] ut_delete_generic_stat: ----Exit-
utdelete-0325 [005A] [21] ut_update_ref_count   : Obj c1239f28 Refs=2, [Incremented]
  utmisc-0970 [005A] [22] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [22] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [21] ut_update_object_refer: ----Exit- AE_OK
utdelete-0647 [005A] [20] ut_add_reference      : ----Exit-
dsmthdat-0495 [005A] [19] ds_method_data_get_val: ----Exit- AE_OK
exresolv-0191 [005A] [18] ex_resolve_object_to_v: [Arg/Local 0] value_obj is c1239f28
utdelete-0668 [005A] [19] ut_remove_reference   : ----Entry c123d128
utdelete-0689 [005A] [19] ut_remove_reference   : Obj c123d128 Current Refs=1 [To Be Decremented]
utdelete-0422 [005A] [20] ut_update_object_refer: ----Entry c123d128
  utmisc-1083 [005A] [21] ut_create_update_state: ----Entry c123d128
 utalloc-0434 [005A] [22] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [22] ut_callocate          : ----Exit- c123d680
 utalloc-0704 [005A] [22] ut_track_allocation   : ----Entry c123d680
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [22] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [21] ut_create_update_state: ----Exit- c123d6a8
  utmisc-1204 [005A] [21] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [22] ut_free               : ----Entry c123d6a8
 utalloc-0788 [005A] [23] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [23] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [24] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [24] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [24] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [24] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [23] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [23] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [23] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [24] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [24] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [24] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [23] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [23] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [22] ut_free               : c123d6a8 freed
 utalloc-0623 [005A] [22] ut_free               : ----Exit-
  utmisc-1208 [005A] [21] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [20] ut_update_ref_count   : Obj c123d128 Refs=0, [Decremented]
utdelete-0078 [005A] [21] ut_delete_internal_obj: ----Entry c123d128
utdelete-0239 [005A] [21] ut_delete_internal_obj: Deleting Object c123d128 [Reference]
utobject-0353 [005A] [22] ut_delete_object_desc : ----Entry c123d128
 utalloc-0596 [005A] [23] ut_free               : ----Entry c123d128
 utalloc-0788 [005A] [24] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [24] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [25] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [25] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [25] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [25] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [24] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [24] ut_remove_allocation  : Freeing size 028
  utmisc-0785 [005A] [24] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [25] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [25] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [25] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [24] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [24] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [23] ut_free               : c123d128 freed
 utalloc-0623 [005A] [23] ut_free               : ----Exit-
utobject-0367 [005A] [22] ut_delete_object_desc : ----Exit-
utdelete-0242 [005A] [21] ut_delete_internal_obj: ----Exit-
  utmisc-0970 [005A] [21] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [21] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [20] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [19] ut_remove_reference   : ----Exit-
exresolv-0300 [005A] [18] ex_resolve_object_to_v: ----Exit- AE_OK
exresolv-0114 [005A] [17] ex_resolve_to_value   : Resolved object c1239f28
exresolv-0115 [005A] [17] ex_resolve_to_value   : ----Exit- AE_OK
dsopcode-1082 [005A] [16] ds_exec_end_control_op: Completed RETURN_OP State=ef245c28, ret_val=c1239f28
 dswexec-0748 [005A] [16] ds_exec_end_op        : ----Exit- ****Exception****: AE_CTRL_TERMINATE
 psparse-0313 [005A] [16] ps_next_parse_state   : ----Entry c123dd28
 psparse-0407 [005A] [16] ps_next_parse_state   : ----Exit- ****Exception****: AE_CTRL_TERMINATE
 psparse-0156 [005A] [16] ps_complete_this_op   : ----Entry c123dd28
  pswalk-0073 [005A] [17] ps_delete_parse_tree  : ----Entry c123dd28
 utalloc-0596 [005A] [18] ut_free               : ----Entry c12ad8a8
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 01C
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c12ad8a8 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
 utalloc-0596 [005A] [18] ut_free               : ----Entry c123dd28
 utalloc-0788 [005A] [19] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [19] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [20] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [20] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [20] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [20] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [19] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [19] ut_remove_allocation  : Freeing size 01C
  utmisc-0785 [005A] [19] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [20] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [20] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [20] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [19] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [19] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [18] ut_free               : c123dd28 freed
 utalloc-0623 [005A] [18] ut_free               : ----Exit-
  pswalk-0105 [005A] [17] ps_delete_parse_tree  : ----Exit-
 psparse-0286 [005A] [16] ps_complete_this_op   : ----Exit-
 psscope-0221 [005A] [16] ps_pop_scope          : ----Entry
 psscope-0249 [005A] [16] ps_pop_scope          : Popped Op 00000000 Args 0
 psscope-0250 [005A] [16] ps_pop_scope          : ----Exit-
 psparse-0951 [005A] [15] ps_parse_loop         : ----Exit- AE_OK
 psparse-1117 [005A] [14] ps_parse_aml          : Completed one call to walk loop, AE_OK State=ef245c28
dswstate-0804 [005A] [15] ds_pop_walk_state     : ----Entry
dswstate-0821 [005A] [15] ds_pop_walk_state     : ----Exit- ef245c28
dswscope-0083 [005A] [14] ds_scope_stack_clear  : Popped object type (Method)
  utmisc-1204 [005A] [15] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [16] ut_free               : ----Entry c123d328
 utalloc-0788 [005A] [17] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [17] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [17] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [16] ut_free               : c123d328 freed
 utalloc-0623 [005A] [16] ut_free               : ----Exit-
  utmisc-1208 [005A] [15] ut_delete_generic_stat: ----Exit-
dsmethod-0496 [005A] [15] ds_terminate_control_m: ----Entry ef245c28
dsmthdat-0134 [005A] [16] ds_method_data_delete_: ----Entry
dsmthdat-0142 [005A] [16] ds_method_data_delete_: Deleting Local0=c1239f28
nsobject-0212 [005A] [17] ns_detach_object      : ----Entry
nsobject-0238 [005A] [17] ns_detach_object      : Node ef245d14 [__L0] Object c1239f28
utdelete-0668 [005A] [18] ut_remove_reference   : ----Entry c1239f28
utdelete-0689 [005A] [18] ut_remove_reference   : Obj c1239f28 Current Refs=2 [To Be Decremented]
utdelete-0422 [005A] [19] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [20] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [21] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [21] ut_callocate          : ----Exit- c123d300
 utalloc-0704 [005A] [21] ut_track_allocation   : ----Entry c123d300
  utmisc-0737 [005A] [21] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [22] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [22] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [22] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [22] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [21] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [21] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [22] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [22] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [22] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [21] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [21] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [20] ut_create_update_state: ----Exit- c123d328
  utmisc-1204 [005A] [20] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [21] ut_free               : ----Entry c123d328
 utalloc-0788 [005A] [22] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [22] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [23] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [23] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [23] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [23] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [22] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [22] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [22] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [23] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [23] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [23] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [22] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [22] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [21] ut_free               : c123d328 freed
 utalloc-0623 [005A] [21] ut_free               : ----Exit-
  utmisc-1208 [005A] [20] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [19] ut_update_ref_count   : Obj c1239f28 Refs=1, [Decremented]
  utmisc-0970 [005A] [20] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [20] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [19] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [18] ut_remove_reference   : ----Exit-
nsobject-0243 [005A] [17] ns_detach_object      : ----Exit-
dsmthdat-0163 [005A] [16] ds_method_data_delete_: ----Exit-
  utmisc-0737 [005A] [15] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Parser]
     osl-0898 [005A] [16] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [16] os_wait_semaphore     : Waiting for semaphore[c11fe860|1|65535]
     osl-0961 [005A] [16] os_wait_semaphore     : Acquired semaphore[c11fe860|1|65535]
     osl-0964 [005A] [16] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [15] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Parser]
  utmisc-0737 [005A] [15] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Namespace]
     osl-0898 [005A] [16] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [16] os_wait_semaphore     : Waiting for semaphore[c11fe7e0|1|65535]
     osl-0961 [005A] [16] os_wait_semaphore     : Acquired semaphore[c11fe7e0|1|65535]
     osl-0964 [005A] [16] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [15] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Namespace]
 nsalloc-0614 [005A] [16] ns_delete_namespace_by: ----Entry 00000364
 nsalloc-0682 [005A] [16] ns_delete_namespace_by: ----Exit-
  utmisc-0785 [005A] [15] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Namespace]
     osl-0979 [005A] [16] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [16] os_signal_semaphore   : Signaling semaphore[c11fe7e0|1]
     osl-0991 [005A] [16] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [15] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Namespace]
  utmisc-0785 [005A] [15] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Parser]
     osl-0979 [005A] [16] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [16] os_signal_semaphore   : Signaling semaphore[c11fe860|1]
     osl-0991 [005A] [16] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [15] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Parser]
dsmethod-0594 [005A] [15] ds_terminate_control_m: ----Exit- AE_OK
 psscope-0274 [005A] [15] ps_cleanup_scope      : ----Entry ef245e18
  utmisc-0970 [005A] [16] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [16] ut_pop_generic_state  : ----Exit- c123dca8
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c123dca8
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c123dca8 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
 psscope-0288 [005A] [15] ps_cleanup_scope      : ----Exit-
 psparse-1191 [005A] [14] ps_parse_aml          : return_value=c1239f28, implicit_value=00000000 State=ef245c28
dswstate-0749 [005A] [14] ds_get_current_walk_st: Current walk_state 00000000
dswstate-1026 [005A] [15] ds_delete_walk_state  : ----Entry ef245c28
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c123d228
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c123d228 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
  utmisc-1204 [005A] [16] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [17] ut_free               : ----Entry c123dda8
 utalloc-0788 [005A] [18] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [18] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [19] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [19] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [19] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [19] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [18] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [18] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [18] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [19] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [19] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [19] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [18] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [18] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [17] ut_free               : c123dda8 freed
 utalloc-0623 [005A] [17] ut_free               : ----Exit-
  utmisc-1208 [005A] [16] ut_delete_generic_stat: ----Exit-
 utalloc-0596 [005A] [16] ut_free               : ----Entry ef245c28
 utalloc-0788 [005A] [17] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [17] ut_remove_allocation  : Freeing size 0240
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [17] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [16] ut_free               : ef245c28 freed
 utalloc-0623 [005A] [16] ut_free               : ----Exit-
dswstate-1070 [005A] [15] ds_delete_walk_state  : ----Exit-
  utmisc-1204 [005A] [15] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [16] ut_free               : ----Entry c123d2a8
 utalloc-0788 [005A] [17] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [17] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [18] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [18] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [18] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [18] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [17] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [17] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [17] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [18] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [18] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [18] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [17] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [17] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [16] ut_free               : c123d2a8 freed
 utalloc-0623 [005A] [16] ut_free               : ----Exit-
  utmisc-1208 [005A] [15] ut_delete_generic_stat: ----Exit-
 psparse-1263 [005A] [14] ps_parse_aml          : ----Exit- AE_OK
  pswalk-0073 [005A] [14] ps_delete_parse_tree  : ----Entry c123d0a8
 utalloc-0596 [005A] [15] ut_free               : ----Entry c123d0a8
 utalloc-0788 [005A] [16] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [16] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [17] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [17] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [17] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [17] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [16] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [16] ut_remove_allocation  : Freeing size 02C
  utmisc-0785 [005A] [16] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [17] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [17] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [17] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [16] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [16] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [15] ut_free               : c123d0a8 freed
 utalloc-0623 [005A] [15] ut_free               : ----Exit-
  pswalk-0105 [005A] [14] ps_delete_parse_tree  : ----Exit-
 psxface-0234 [005A] [13] psx_execute           : Method returned obj_desc=c1239f28
  exdump-0117 [005A] [13] ex_dump_operand       : c1239f28 Buffer len 5E @ f55adda8 
Buffer Contents:  8a 2b 00 00 0c 01 00 00 00 00 00 00 00 00 00 00 00 c0 01 00 00 00 ff ff ff 3f 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 00 8a 2b 00 00 0c 01 00 00 00 00 00 00 00 00 00 00 00 40
 psxface-0240 [005A] [13] psx_execute           : ----Exit- ****Exception****: AE_CTRL_RETURN_VALUE
 exutils-0127 [005A] [13] ex_exit_interpreter   : ----Entry
  utmisc-0785 [005A] [13] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Execute]
     osl-0979 [005A] [14] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [14] os_signal_semaphore   : Signaling semaphore[c11fe8a0|1]
     osl-0991 [005A] [14] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [13] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Execute]
 exutils-0135 [005A] [13] ex_exit_interpreter   : ----Exit-
  nseval-0409 [005A] [12] ns_execute_control_met: ----Exit- ****Exception****: AE_CTRL_RETURN_VALUE
  nseval-0340 [005A] [11] ns_evaluate_by_handle : ----Exit- AE_OK
  nseval-0145 [005A] [10] ns_evaluate_relative  : *** Completed eval of object _CRS ***
  utmisc-1204 [005A] [11] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [12] ut_free               : ----Entry c123d628
 utalloc-0788 [005A] [13] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [13] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [14] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [14] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [14] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [14] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [13] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [13] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [13] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [14] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [14] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [14] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [13] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [13] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [12] ut_free               : c123d628 freed
 utalloc-0623 [005A] [12] ut_free               : ----Exit-
  utmisc-1208 [005A] [11] ut_delete_generic_stat: ----Exit-
 utalloc-0596 [005A] [11] ut_free               : ----Entry c1217f68
 utalloc-0788 [005A] [12] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [12] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [13] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [13] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [13] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [13] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [12] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [12] ut_remove_allocation  : Freeing size 08
  utmisc-0785 [005A] [12] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [13] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [13] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [13] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [12] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [12] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [11] ut_free               : c1217f68 freed
 utalloc-0623 [005A] [11] ut_free               : ----Exit-
  nseval-0152 [005A] [10] ns_evaluate_relative  : ----Exit- AE_OK
  uteval-0232 [005A] [09] ut_evaluate_object    : ----Exit- AE_OK
rscreate-0084 [005A] [09] rs_create_resource_lis: ----Entry
rscreate-0088 [005A] [09] rs_create_resource_lis: byte_stream_buffer = c1239f28
  rscalc-0319 [005A] [10] rs_get_list_length    : ----Entry
  rscalc-0716 [005A] [10] rs_get_list_length    : ----Exit- AE_OK
rscreate-0104 [005A] [09] rs_create_resource_lis: Status=0 list_size_needed=C4
  rslist-0133 [005A] [10] rs_byte_stream_to_list: ----Entry
  rsaddr-0860 [005A] [11] rs_address64_resource : ----Entry
  rsaddr-1066 [005A] [11] rs_address64_resource : ----Exit- AE_OK
  rsaddr-0860 [005A] [11] rs_address64_resource : ----Entry
  rsaddr-1066 [005A] [11] rs_address64_resource : ----Exit- AE_OK
  rsmisc-0084 [005A] [11] rs_end_tag_resource   : ----Entry
  rsmisc-0106 [005A] [11] rs_end_tag_resource   : ----Exit- AE_OK
  rslist-0328 [005A] [10] rs_byte_stream_to_list: ----Exit- AE_OK
rscreate-0125 [005A] [09] rs_create_resource_lis: output_buffer f55aa280 Length C4
rscreate-0126 [005A] [09] rs_create_resource_lis: ----Exit- AE_OK
utdelete-0668 [005A] [09] ut_remove_reference   : ----Entry c1239f28
utdelete-0689 [005A] [09] ut_remove_reference   : Obj c1239f28 Current Refs=1 [To Be Decremented]
utdelete-0422 [005A] [10] ut_update_object_refer: ----Entry c1239f28
  utmisc-1083 [005A] [11] ut_create_update_state: ----Entry c1239f28
 utalloc-0434 [005A] [12] ut_callocate          : ----Entry 00000058
 utalloc-0457 [005A] [12] ut_callocate          : ----Exit- c123d600
 utalloc-0704 [005A] [12] ut_track_allocation   : ----Entry c123d600
  utmisc-0737 [005A] [12] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [13] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [13] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [13] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [13] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [12] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
  utmisc-0785 [005A] [12] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [13] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [13] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [13] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [12] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0756 [005A] [12] ut_track_allocation   : ----Exit- AE_OK
  utmisc-1099 [005A] [11] ut_create_update_state: ----Exit- c123d628
  utmisc-1204 [005A] [11] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [12] ut_free               : ----Entry c123d628
 utalloc-0788 [005A] [13] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [13] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [14] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [14] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [14] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [14] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [13] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [13] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [13] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [14] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [14] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [14] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [13] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [13] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [12] ut_free               : c123d628 freed
 utalloc-0623 [005A] [12] ut_free               : ----Exit-
  utmisc-1208 [005A] [11] ut_delete_generic_stat: ----Exit-
utdelete-0341 [005A] [10] ut_update_ref_count   : Obj c1239f28 Refs=0, [Decremented]
utdelete-0078 [005A] [11] ut_delete_internal_obj: ----Entry c1239f28
utdelete-0108 [005A] [11] ut_delete_internal_obj: **** Buffer c1239f28, ptr f55adda8
utdelete-0232 [005A] [11] ut_delete_internal_obj: Deleting Object Subptr f55adda8
 utalloc-0596 [005A] [12] ut_free               : ----Entry f55adda8
 utalloc-0788 [005A] [13] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [13] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [14] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [14] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [14] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [14] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [13] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [13] ut_remove_allocation  : Freeing size 05E
  utmisc-0785 [005A] [13] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [14] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [14] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [14] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [13] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [13] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [12] ut_free               : f55adda8 freed
 utalloc-0623 [005A] [12] ut_free               : ----Exit-
utdelete-0239 [005A] [11] ut_delete_internal_obj: Deleting Object c1239f28 [Buffer]
utobject-0353 [005A] [12] ut_delete_object_desc : ----Entry c1239f28
 utalloc-0596 [005A] [13] ut_free               : ----Entry c1239f28
 utalloc-0788 [005A] [14] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [14] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [15] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [15] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [15] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [15] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [14] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [14] ut_remove_allocation  : Freeing size 028
  utmisc-0785 [005A] [14] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [15] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [15] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [15] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [14] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [14] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [13] ut_free               : c1239f28 freed
 utalloc-0623 [005A] [13] ut_free               : ----Exit-
utobject-0367 [005A] [12] ut_delete_object_desc : ----Exit-
utdelete-0242 [005A] [11] ut_delete_internal_obj: ----Exit-
  utmisc-0970 [005A] [11] ut_pop_generic_state  : ----Entry
  utmisc-0982 [005A] [11] ut_pop_generic_state  : ----Exit- 00000000
utdelete-0601 [005A] [10] ut_update_object_refer: ----Exit- AE_OK
utdelete-0697 [005A] [09] ut_remove_reference   : ----Exit-
 rsutils-0267 [005A] [08] rs_get_method_data    : ----Exit- AE_OK
acpi_motherboard-0059 [005A] [08] acpi_reserve_io_ranges: ----Entry
acpi_motherboard-0089 [005A] [08] acpi_reserve_io_ranges: ----Exit- 0000000000000000
acpi_motherboard-0059 [005A] [08] acpi_reserve_io_ranges: ----Entry
acpi_motherboard-0089 [005A] [08] acpi_reserve_io_ranges: ----Exit- 0000000000000000
 rsxface-0315 [005A] [07] acpi_walk_resources   : ----Exit- AE_OK
    scan-0563 [005A] [06] acpi_bus_driver_init  : Driver successfully bound to device
    scan-0569 [005A] [06] acpi_bus_driver_init  : ----Exit- 0000000000000000
    scan-0717 [005A] [05] acpi_bus_find_driver  : ----Exit- 0000000000000000
    scan-1154 [005A] [04] acpi_bus_add          : ----Exit- 0000000000000000

 driver data not foundacpi_memory-0159 [005A] [03] acpi_memory_get_device: ----Exit- FFFFFFFFFFFFFFED
acpi_memory-0310 [005A] [02] acpi_memory_device_not: Error in finding driver data
acpi_memory-0311 [005A] [02] acpi_memory_device_not: ----Exit-
  utmisc-1204 [005A] [02] ut_delete_generic_stat: ----Entry
 utalloc-0596 [005A] [03] ut_free               : ----Entry c12399a8
 utalloc-0788 [005A] [04] ut_remove_allocation  : ----Entry
  utmisc-0737 [005A] [04] ut_acquire_mutex      : Thread 5A attempting to acquire Mutex [ACPI_MTX_Memory]
     osl-0898 [005A] [05] os_wait_semaphore     : ----Entry
     osl-0906 [005A] [05] os_wait_semaphore     : Waiting for semaphore[c11fe760|1|65535]
     osl-0961 [005A] [05] os_wait_semaphore     : Acquired semaphore[c11fe760|1|65535]
     osl-0964 [005A] [05] os_wait_semaphore     : ----Exit- AE_OK
  utmisc-0743 [005A] [04] ut_acquire_mutex      : Thread 5A acquired Mutex [ACPI_MTX_Memory]
 utalloc-0827 [005A] [04] ut_remove_allocation  : Freeing size 030
  utmisc-0785 [005A] [04] ut_release_mutex      : Thread 5A releasing Mutex [ACPI_MTX_Memory]
     osl-0979 [005A] [05] os_signal_semaphore   : ----Entry
     osl-0987 [005A] [05] os_signal_semaphore   : Signaling semaphore[c11fe760|1]
     osl-0991 [005A] [05] os_signal_semaphore   : ----Exit- AE_OK
  utmisc-0835 [005A] [04] ut_release_mutex      : Thread 5A released Mutex [ACPI_MTX_Memory]
 utalloc-0830 [005A] [04] ut_remove_allocation  : ----Exit- AE_OK
 utalloc-0621 [005A] [03] ut_free               : c12399a8 freed
 utalloc-0623 [005A] [03] ut_free               : ----Exit-
  utmisc-1208 [005A] [02] ut_delete_generic_stat: ----Exit-
     osl-0680 [005A] [01] os_execute_deferred   : ----Exit-

--=-mVhJryNovFlaK2oIp2aG--



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
