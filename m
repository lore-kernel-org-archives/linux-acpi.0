From: maxime bizon <maxime.bizon-ZrNlpQwM5lQ@public.gmane.org>
Subject: Bitfield usage in FADT table?
Date: Tue, 11 Nov 2003 17:15:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031111161527.GC23128@sh.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hello,

I'm using kernel 2.6.0-test9 on a i386 notebook.

I forced a new FADT table in the kernel and put the following bytes at
offset 0x70:  0xf1 0xa2 0x35 0x78.

Then I made some printk at kernel init and here is the output:

begin dump of fadt:
[...]
6e	0
6f	0
70	f1
71	a2
72	35
73	78
74	0
75	0
[...]
bit wb_invd is 1
bit wb_invd_flush is 0
bit proc_c1 is 0
bit plvl2_up is 0
bit pwr_button is 1
bit sleep_button is 1
bit fixed_rTC is 1
bit rtcs4 is 1
bit tmr_val_ext is 0
bit dock_cap is 1
bit reset_reg_sup is 0
bit sealed_case is 0
bit headless is 0
bit cpu_sw_sleep is 1

gcc-2.95 and gcc-3.3 give the same thing.


Is it really what it is supposed to be?

-- 
Maxime


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
