From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 11:57:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FBDEFB3.3060303@pca.it>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031121101232.GL32464-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 11/21/03 11:12, Ducrot Bruno wrote:
| I'm using laptop-mode which is now in linux-2.4 since 2.4.23-pre7.
| You should really look at.  Look at linux/Documentation/laptop-mode.txt
| for more details.
sorry, I read the doc but I couldn't found all the info I need... :-(

~From the doc above...
| The main knob is /proc/sys/vm/laptop_mode. Setting that to 1 switches the
| vm (and block layer) to laptop mode. Leaving it to 0 makes the kernel work
| like before. When in laptop mode, you also want to extend the intervals
| desribed above. See the laptop-mode.sh script for how to do that.
1) As I understood, to enable 'laptop_mode' I just need to do an
	echo 1 > /proc/sys/vm/laptop_mode
right? I mean, it's already present in the kernel, I don't need to
enable any new features in kernel config or somewhere else, right?

2) Where I can find 'laptop-mode.sh'??? It's not present in kernel
source dir...

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/ve+yVAp7Xm10JmkRAhbmAJ9BwYbGTnQAGKaT66Ixs4PqAi1k+wCaAv4z
YbadY+gQZi/2b/Eiex+APZY=
=TvIN
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
