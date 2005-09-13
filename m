From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] Fixed buffered ACPI events for a lot ASUS machines
Date: Tue, 13 Sep 2005 17:08:53 +0800
Message-ID: <200509131708.53544.luming.yu@intel.com>
References: <432568E3.6040401@suse.de> <200509131031.43570.luming.yu@intel.com> <43267D43.3070305@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43267D43.3070305-l3A5Bk7waGM@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, jfvasconcelos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>
>  I used vanilla-2.6.13 with acpica-20050902 patches on it.
Yes, this version has latest ec patch.
>  So it still seems to be used, at least on ASUS machines.
>  One of your old EC-burst patches in
>  http://bugzilla.kernel.org/show_bug.cgi?id=3851
>  had this little change. After reports of working ASUS machines with
>  this one, I found that newer EC-burst version do not have this
>  change anymore, but behave as the non EC-burst code on these machines.
It should be old behavior.  Because, ec gpe will be wrongly disabled in some 
cases.  I think the issue should be fixed in the latest ec patch. Because, ec 
gpe is always be enabled at run-time.

>
>  Therefore I asked whether this change was intended or whether it is
>  a bug that slipped in by accident. So I expect the latter?
You are right. The change pointed out by your previous mail  was somehow 
dropped in the previous EC driver release. 

Anyway, please make sure the latest ec driver works as expected.
ec_burst=1 is still needed to enable ec murst mode.

Thanks,
Luming


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
