From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Freezing more and more (Gericom Supersonic M6T)
Date: Fri, 7 Mar 2003 10:50:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030307095014.GA28237@schiggy.intern.quelltext.com>
References: <200303041529.11172.Pavel.Vondricka@ff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200303041529.11172.Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

strange, I also have a Gericom 1st Supersonic M6-T, and it also
sometimes locks up during booting or when repeatedly removing and
inserting a PCMCIA WLAN card, but I don't have the same amount of
problems that you have. My machine runs mostly stable with all of

    Linux 2.4.18      + acpi-20020517
    Linux 2.4.19      + acpi-20020821
    Linux 2.4.20      + acpi-20030228
and Linux 2.4.21-pre5 + acpi-20030228

(These are the kernels that I still have installed.)

However, I had problems with KDE 3.1 and

    Linux 2.4.20      + acpi-20021212
and Linux 2.4.21-pre4 + acpi-20030123

The KDE startup would hang during the "initializing devices" phase;
often the machine would freeze, and after rebooting I had files with
invalid names on my ext3 partitions (files with \0 in the file name).
Therefore, I had to go back to Linux 2.4.19 + acpi-20020821 to use KDE
3.1 until I found out that the problems are gone with acpi-20030228.
(KDE 2.2 did always work without any problems.)

BTW, I am using Debian "sid" (aka unstable).

Good luck,
Arndt

-- 
Arndt Schönewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
