From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Thu, 29 Jan 2004 10:15:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4018CF17.4040606@pca.it>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it> <20040128200719.M75620@morningdave.org> <40181916.2050408@xms.se> <40182D90.8090102@pca.it> <4018B6F1.3070607@xms.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4018B6F1.3070607-7RBX4Gk6oWI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 01/29/04 08:32, Jonas Petersson wrote:
> Yep, sounds like we are in the same state. I've not been around long
> enough to know the whole history for sure, but it appears that Nigel has
> worked for quite some time on swsusp on 2.4 and Pavel has worked on a
> 2.6(pre) as different branches some original "swsusp". Now that Nigel is
> going 2.6 the two branches are rather different and hence Nigel's 2.6
> version is called swsusp2 while his 2.4 version is just swsusp. Somewhat
> confusing... So far Nigels stuff is only available as a patch.
yes, this is what I know... IMHO the /problem/ is that Nigel's project
site is 'swsusp.sf.net', so far confusing for a newbie (who doesn't know
the whole story).

> suspends while hunting down some incompatible drivers - for instance the
>  LinuxAnt driver for the builtin wireless card...
The same here if I leave 'ndiswrapper' loaded. IMHO the problem with all
the NDIS wrapper (Linuxand and NDISwrapper) is that they aren't Linux
native drivers, so it could be more difficult to implement power
management. Anyway, I'll pass to a native Linux Intel Centrino driver,
as soon as it will be one: Jon Lech Johansen started one which could
read the MAC address, but his site is no more on and I can't find other
info :-( (BTW, I don't have the capacities to continue his work)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAGM8WVAp7Xm10JmkRApu1AKCAwAUGw0rU5v4T3llm25kYxLBX8QCfS9lD
3rKdjPqU99AxViGaiyCuYQg=
=Kv0V
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
