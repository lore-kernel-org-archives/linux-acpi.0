From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi
 while  "Executing all Devices _STA and_INIT methods"
Date: Tue, 15 Jul 2003 22:43:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F146770.8020603@free.fr>
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E9702C-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Grover, Andrew wrote:
>>From: Eric Valette [mailto:eric.valette-GANU6spQydw@public.gmane.org] 
>>I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
>>fine. I tried today 2.6-pre1 with exactly the same hardware 
>>configuration as the 2.4 one and the laptop does not boot. It hangs 
>>while dispaying : "Executing all Devices _STA and_INIT methods" 
>>allthough it has already printed several '.'
> 
> 
> That's weird. They should have the same version of the ACPI code...

Thanks for responding. Note I have never seen such messages on 2.4 so...

FYI : I tested today with the latest version 0714 and it doesn't change 
  anything... 2.4.22-pre6 + the patch works fine... Someone suggested 
problem with the APIC but its enabled in 2.4...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
