From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI  question
Date: Mon, 12 May 2003 18:59:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030512165913.GG19475@poup.poupinou.org>
References: <CD08F83C0FFD554CBE4D42ABADAC140904A25F@tpeex03.intranet.compal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CD08F83C0FFD554CBE4D42ABADAC140904A25F-264r6xcw3CrbFIwZ3jqLltv2kNAIRLhc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Allen_Lee-uiv9WLrdKoDQT0dZR+AlfA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 12, 2003 at 02:21:54PM +0800, Allen_Lee-uiv9WLrdKoDQT0dZR+AlfA@public.gmane.org wrote:
> Dear all:
>           ACPI work well on my platform (Toshiba machine + Redhat 8.0 +
> kernel 2.4.20).
> The machine directly shutdown in S5 but it won't umount HDD before doing
> that. It will
> damage my HDD. Who has good idea to deal with this problem? (How to umount
> HDD 
> before entering S5?)
>  
> Thanks in advance!
>  
> Allen


I am happy to see that a Compal guy is trying Linux with latest acpi.
I have seen some trouble with Toshiba-compal laptops, plus, I have
added a thermal zone definition for some of them, with passive control,
which do not exist in the AML.  Can I send some of those reports to you
in order to get it in BIOS ?  Toshiba do not answer to me, and I must
admit I have not tryed to contact Compal for this purpose.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
