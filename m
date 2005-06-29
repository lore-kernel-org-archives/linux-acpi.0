From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 29 Jun 2005 17:10:57 +0200
Message-ID: <42C2BA01.2060806@gmx.net>
References: <20050618004506.GE3690@orest.greek0.net> <20050629111044.GA2910@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050629111044.GA2910-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor schrieb:
> Thus wrote Christian Aichinger:
> 
>>The oops occurs in asus_acpi.c, line 1016:
>>    hotk->model = END_MODEL;
>>	if (strncmp(model->string.pointer, "L3D", 3) == 0) // <-- OOPS
>>		hotk->model = L3D;
>>
>>Some added debug printk's later it turned out that:
>>model->type == ACPI_TYPE_INTEGER
>>model->integer.value == 56
> 
> 
> Thanks, I suspected that but I'm really swamped both with Real Work and
> my exams so I'm slow even with catching up with the lists...
> 
> 
>>This is why the problem wasn't fixed by your patch, since that
>>resided in the if (model->type == ACPI_TYPE_STRING) code-path.
>>I've attatched a patch that works for me, but IMHO it's ugly and
>>only fixes the sympthoms. Why do we get an integer here in the first
>>place?
> 
> 
> Bob, is the implicit return code supposed to trigger also when using
> acpi_evaluate_object()? FYI, this is what we currently do:
> 
> write_acpi_int(hotk->handle, "INIT", 0, &buffer) (drivers/acpi/asus_acpi.c)
> 
> which is fine if the INIT method returns a string (the usual), but
> apparently not if there is no return statement in the method (the P30
> case). The old code assumed the buffer will be null in this case.
> 
> Is that a bug in the ACPICA or should the asus_acpi code cover for other
> cases of buffer.type?

Will the fix for this be submitted to stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org? I can't upgrade
to 2.6.12.1 because of this oops.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
