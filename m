From: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: RE: ACPI source releases updated (20030509)
Date: Tue, 13 May 2003 13:55:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EC13FAF.1030509@hp.com>
References: <F760B14C9561B941B89469F59BA3A84725A299@orsmsx401.jf.intel.com> <b9pf9o$jjs$1@main.gmane.org> <20030513085421.GB1338@enigma.daemon.sh> <b9re0e$u0h$1@main.gmane.org>
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
To: Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> I think the only criticism I have of this patch is that (IMVeryHO) it
>> doesn't strike me as suitable for long-term inclusion in the kernel.  I
>> imagine it would be better to allow the user to specify dsdt=/boot/dsdt.img
>> in the same way he specifies initrd=/boot/initrd.img so that these two
>> things can be kept cleanly separated.


Better yet, I would like to see the mkinitrd modified so that it rolls 
in the dsdt table
into the initrd. It may make it (the modified dsdt table) easier to 
access later if
manual inspection of the initrd.img is required. This would be similar 
to the
recent changes to mkinitrd to include ext3 and jbd if any filesystems 
are using ext3.
Maybe a pointer to the current dsdt table could be kept in 
/etc/modules.conf:

#/etc/modules.conf
alias dsdt /boot/dsdt.img

Sincerely,
Richard Black



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
