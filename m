From: Carlos Morgado <chbm-tNiY1ywYjSU@public.gmane.org>
Subject: Re: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 16:53:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827155320.GA2998@whisky.cprm.net>
References: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
Reply-To: chbm-tNiY1ywYjSU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020827091844.7af7a982.jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>; from jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org on Tue, Aug 27, 2002 at 15:18:44 +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 2002.08.27 15:18:44 +0100 Jamin W. Collins wrote:

> I'm able to run either ESD or ASD with a non-ACPI kernel without these
> symptoms and likewise, running the ACPI kernel without ESD or ASD results
> in normal CPU utilization.
> 

check the irq distribution on an apm and an acpi kernel

-- 
Carlos Morgado - chbm(at)chbm(dot)nu - http://chbm.nu/ -- gpgkey: 0x1FC57F0A
http://wwwkeys.pgp.net/ FP:0A27 35D3 C448 3641 0573 6876 2A37 4BB2 1FC5 7F0A
Software is like sex; it's better when it's free. - Linus Torvalds


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
