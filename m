From: Cedric Hans <acpi-CBqLTWQLpQY@public.gmane.org>
Subject: more infos about kernel panic fujitsu
Date: Sun, 07 Sep 2003 17:34:11 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F5BA453.7010200@mlkj.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have more infos about the kernel panic experienced on Fujitsu E7010 
series laptop when ACPI is enabled.
(see http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/0713.html )

(kernel-2.6.0-test4)
The kernel crash in resource/nsutils.c line 740 :
if (ACPI_GET_DESCRIPTOR_TYPE (handle) != ACPI_DESC_TYPE_NAMED) {

because handle == 7 and
#define ACPI_GET_DESCRIPTOR_TYPE(d)     (((union acpi_descriptor *)(void 
*)(d))->descriptor_id)

this value is set in resource/rsmisc.c line 95 function 
acpi_rs_end_tag_resource:
output_struct->id = ACPI_RSTYPE_END_TAG;

in resource/rslist.c function acpi_rs_byte_stream_to_list
output_buffer (= output_struct) is changed to the same value than handle

Since I don't see how to fix the code, I have this ugly workaround :
in pci_root.c line 294:
handle = device->handle;
acpi_pci_evaluate_crs(root);
device->handle = handle;
handle = NULL;

-- 
Cedric Hans



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
