From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Mon, 15 Nov 2004 23:10:08 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411152304451.5265@frog.athome>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
 <200411031958.47910.christian.hesse@linuxob.de>  <Pine.LNX.4.60.0411032322410.4984@frog.athome>
 <1099534267.3991.52.camel@desktop.cunninghams> <Pine.LNX.4.60.0411041242210.1565@frog.athome>
 <Pine.LNX.4.60.0411041729180.4727@frog.athome> <Pine.LNX.4.60.0411062301590.5414@frog.athome>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411062301590.5414-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Folks,
On Sat, 6 Nov 2004 liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> I tryed today Linux-2.6.10-rc1 (without Swsusp-2.1.1). To get the prorietary 
> Nvidia-driver compiled, you may want to apply the attached patch 
> nv-2.9.10-rc1-incl-haggis.diff. I did not try, to have only the changes 
> needed for 2.6.9- 2.6.10-rc1 (which is the other attached patch). Don't even 
> know, if the compiler likes it. Both patches are aginst the Nvidia-driver...
> But for me, I could not get the machine going down to suspend. It shutdown 
> the screen, and then sit there as long as you let it. By issuing some ACPI 
> event, I always got it back to live, e.g. lid-switch, power-button ...
So with 2.6.10-rc2 this regression is gone for me. We have another working 
combination: vanilla 2.6.10-rc2 and nvidia-6111+haggis+my-patch.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBmSlF9bBoTzOf1pMRAlu7AKDeIiDSIRxxVa2qGa7JGtAixJAtPgCfTqGr
vrWbRPeq2UBuY4WaLZRUEsM=
=LZ+X
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
