From: Nigel Cunningham <ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake
	howto was: RE: [BKPATCH] ACPI for 2.6
Date: Thu, 01 Apr 2004 16:15:39 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080800139.1887.28.camel@calvin.wpcb.org.au>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>
	 <20040330233155.463A.COUNT0@localnet.com>
Reply-To: ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040330233155.463A.COUNT0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Cc: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

I care.

And what is more, you're overstating the case. Suspend2 has worked with
SMP since January and Highmem since mid last year (IIRC) under 2.4,
thanks to the people at LinuxFund.org, who cared enough to sponsor 4
mounths of work on the project. Gary Sandine at LACLinux also cares, so
much so that I am now able to keep the SMP/Highmem support working and
will shortly begin work on getting these features going under 2.6.
Furthermore, suspend2 has received a ton of testing, thanks especially
to Michael Frank.

That said, I do fully agree with you that hardware support in some key
areas is way short of the mark. Rest assured, though, it is possible: I
am typing this on a SMP box with Highmem and an ATI Radeon 9000. It's
not perfectly robust at resuming yet (I've only been using it one day),
but I care and I'll be working on improving suspend so far as I'm able.
What is more, others are working on it too.

Don't give up!

Regards,

Nigel

-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
