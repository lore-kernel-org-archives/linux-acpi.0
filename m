From: Gilberto Ficara <g.ficara-3ibPxRg+o6HAUvMvb8FJ8A@public.gmane.org>
Subject: Re: Is it possibile that ACPi messes my battery ...
Date: Wed, 2 Oct 2002 18:05:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021002180521.50011a7f.g.ficara@linuxpratico.com>
References: <20021001001656.GC9965@geolandia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021001001656.GC9965-CwhMdJBTcbtgNr7TIQy98w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In data astrale Tue, 1 Oct 2002 02:16:56 +0200,
il tenente "Antonio G. - Geotronix" <antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org> della Flotta Stellare,
nel messaggio cifrato 20021001001656.GC9965-CwhMdJBTcbtgNr7TIQy98w@public.gmane.org ([ACPI] Is it possibile that ACPi messes my battery ...), ha scritto:

> I don't know if something like this is possible however I don't think so
> but yet I will ask the same. I have noticed that in a few month, without
> any heavy duty, my Li-ion battery for my Preassrio 710EA has declined in
> full capacity. While the cat of /proc/acpi/battery/BAT0/state has always
> told me that "design capacity: 53280 mWh" the "last full capcity:" has
> declined from "43200 mWh" to the now "26669 mWh".

velenux@ares:~$ cat /proc/acpi/battery/BAT0/info  
present:                 yes
design capacity:         53280 mWh
last full capacity:      15969 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 1583 mWh
design capacity low:     0 mWh
capacity granularity 1:  1480 mWh
capacity granularity 2:  1480 mWh
model number:            6000
serial number:           1
battery type:            4
OEM info:                 COMPAQ 

same problem.
The notebook is a Compaq EVO N115 (pretty similar to the presario 700
series, I think).

can anyone help or explain ?

G.

-- 
Gilberto "Velenux" Ficara
http://velenux.oltrelinux.com
<g.ficara-kbMWSTjsVoGjGiRLkfLokA@public.gmane.org>

------BEGIN GEEKCODE BLOCK------
Version: 3.12
GPA/GTW dpu s+:+ a-- C++++ UL++++ P+++ !E W+++
N++ o? K? w--- O? M-- V? PS+++ PE- Y+ PGP t+
5? X+ R* tv- b+++ DI? D++ G++ e++ h* r-- z?
------END GEEK CODE BLOCK------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
