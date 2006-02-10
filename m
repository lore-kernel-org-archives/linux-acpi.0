From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
Date: Fri, 10 Feb 2006 13:54:12 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AD5B4D@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:57048 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932212AbWBJVyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2006 16:54:19 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

>Does any debug info come out?

Perhaps I was too impatient ... I just assumed it was hung
because it hadn't said anything for a minute after the
"Loading initrd" message.  When I came back to the console
all sorts of messages were streaming past.

I restarted ... the delay is ~10 minutes, the the output
begins not with the regular kernel messages, but with this:

 Storing e00000407f4bd108(Integer) into node
e00000407e8e9a30(BufferField)
exstoren-0075 [18] ex_resolve_object     : ----Entry
exstoren-0155 [18] ex_resolve_object     : ----Exit- AE_OK
 exfield-0222 [18] ex_write_data_to_field: ----Entry e00000407efa7dc0
 exfield-0354 [18] ex_write_data_to_field: field_write [FROM]: Obj
e00000407f4bd108 (Integer:1), Buf e00000407f4bd120, byte_len 8
 exfield-0363 [18] ex_write_data_to_field: field_write [TO]:  Obj
e00000407efa7dc0 (BufferField:E), bit_len 20, bit_off 0, byte_off 13
 exutils-0192 [19] ex_acquire_global_lock: ----Entry
 exutils-0208 [19] ex_acquire_global_lock: ----Exit- 0000000000000000
 exfldio-0783 [19] ex_insert_into_field  : ----Entry
 exfldio-0562 [20] ex_write_with_update_r: ----Entry FFFFFFFF
 exfldio-0631 [20] ex_write_with_update_r: Mask FFFFFFFFFFFFFFFF,
datum_offset 0, Width 4, Value 00000000FF5E0000, merged_value
00000000FF5E0000
 exfldio-0355 [21] ex_field_datum_io     : ----Entry 00000000
 exfldio-0530 [21] ex_field_datum_io     : Value Written
00000000FF5E0000, Width 4
 exfldio-0534 [21] ex_field_datum_io     : ----Exit- AE_OK

It is unclear whether the system is making progress.



I tried using CONFIG_ACPI_DEBUG=y on an Intel tiger.  It booted ok.


-Tony
