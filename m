From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI and my IBM Thinkpad R32
Date: Fri, 14 Feb 2003 22:21:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030214212155.GZ25625@poup.poupinou.org>
References: <20030214170712.6e70c356.linux.wali@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030214170712.6e70c356.linux.wali-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 14, 2003 at 05:07:12PM +0100, Michael Wahlbrink wrote:
> Hi,
> here comes an ACPI-Newbie with some (perhaps stupid) questions ;-)
> I've got an IBM Thinkpad R32 (Type 2658-DCG) and tried to get linux working on it. Ok all is set up excl. powersave etc.. (the ACPI) stuff. I've tried a vanilla 2.4.19 kernel enabled acpi and got some informations about battery temperature etc in /proc/acpi/ . Then I've read an article about linux and ACPI in the german ct'.  ...And so I've found this project... Ok, I patched a 2.4.20 and a 2.4.21-pre3 kernel with the ACPI-patches from sf. Now I got no readable Information in /proc .. :-( Now I get the following messages about acpi when booting up (kernel 2.4.12-pre3 with patch):
> 

There is a little problem in this laptop.
IBM will release soon a bios upgrade.

In the meantime, you can check
http://www.poupinou.org/acpi/ibm_ecdt.html
for a workaround.


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
