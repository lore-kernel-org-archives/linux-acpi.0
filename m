From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [Acpi4asus-user] Re: Re: [PATCH] Fixed buffered ACPI events
 for a lot ASUS machines
Date: Tue, 13 Sep 2005 12:39:01 +0200
Message-ID: <4326AC45.3080006@suse.de>
References: <432568E3.6040401@suse.de> <200509131031.43570.luming.yu@intel.com> <43267D43.3070305@suse.de> <200509131708.53544.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509131708.53544.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jfvasconcelos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yu Luming wrote:
>>  I used vanilla-2.6.13 with acpica-20050902 patches on it.
> Yes, this version has latest ec patch.
>>  So it still seems to be used, at least on ASUS machines.
>>  One of your old EC-burst patches in
>>  http://bugzilla.kernel.org/show_bug.cgi?id=3851
>>  had this little change. After reports of working ASUS machines with
>>  this one, I found that newer EC-burst version do not have this
>>  change anymore, but behave as the non EC-burst code on these machines.
> It should be old behavior.  Because, ec gpe will be wrongly disabled in some 
> cases.  I think the issue should be fixed in the latest ec patch. Because, ec 
> gpe is always be enabled at run-time.
> 
Yes, seems as if you are right.
I mixed up kernels during testing.
This seems to be sovled with latest 20050902 patch.
Sorry for this one, I am a bit in a pressure of time...

Could you please line out the change to the older ec_burst patch by some
code.
It's very hard to pitch on the big ACPICA commits for little fixes.
ec_burst patch will be enabled in SUSE Linux 10.0 by default.
Beside lost mouse/key-strokes on some specific machines (also happen with 
ec_burst=0), I don't know of any greater harm ec_burst causes.
If you know any other issues I'd appreciate if you let me know.

Hmm, searching for something that could have fixed it in the to-akpm/broken-out
directory of Len, I don't find anything than the huge ACPICA-20050408 commit...

Thanks,

      Thomas




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
