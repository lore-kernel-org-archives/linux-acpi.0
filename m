From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Bitfield usage in FADT table?
Date: Tue, 11 Nov 2003 09:23:16 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031111092316.124cdfa0.rddunlap@osdl.org>
References: <20031111161527.GC23128@sh.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031111161527.GC23128-AroONJ29hSVWj0EZb7rXcA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: maxime bizon <maxime.bizon-ZrNlpQwM5lQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 11 Nov 2003 17:15:28 +0100 maxime bizon <maxime.bizon-ZrNlpQwM5lQ@public.gmane.org> wrote:

| 
| Hello,
| 
| I'm using kernel 2.6.0-test9 on a i386 notebook.
| 
| I forced a new FADT table in the kernel and put the following bytes at
| offset 0x70:  0xf1 0xa2 0x35 0x78.
| 
| Then I made some printk at kernel init and here is the output:
| 
| begin dump of fadt:
| [...]
| 6e	0
| 6f	0
| 70	f1
| 71	a2
| 72	35
| 73	78
| 74	0
| 75	0
| [...]
| bit wb_invd is 1
| bit wb_invd_flush is 0
| bit proc_c1 is 0
| bit plvl2_up is 0
| bit pwr_button is 1
| bit sleep_button is 1
| bit fixed_rTC is 1
| bit rtcs4 is 1
| bit tmr_val_ext is 0
| bit dock_cap is 1
| bit reset_reg_sup is 0
| bit sealed_case is 0
| bit headless is 0
| bit cpu_sw_sleep is 1
| 
| gcc-2.95 and gcc-3.3 give the same thing.
| 
| Is it really what it is supposed to be?

It can be confusing, can't it?

Yes, I think that they are correct.
Look at the bit field as a u32:  it's value is 0x7835a2f1.

Now look at the bit numbers in that u32 value and assign bit field
names to them and it will match your list above.

--
~Randy
MOTD:  Always include version info.


simple bitfields program output:

[rddunlap-GKM3wtwTCu0@public.gmane.org src]$ ./bitfields
bits as u32 = 0x7835a2f1
bytes (hex):  f1 a2 35 78
individual bits:
wb_invd:        1
wb_invd_flush:  0
proc_c1:        0
plvl2_up:       0
pwr_button:     1
sleep_button:   1
fixed_rTC:      1
rtcs4:          1
tmr_val_ext:    0
dock_cap:       1
reset_reg_sup:  0
sealed_case:    0
headless:       0
cpu_sw_sleep:   1
reserved6:    0x1e0d6


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
