From: Maciek Gorniak <mago-StWSBrfNG1XVItvQsEIGlw@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: 23 Sep 2002 21:02:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032807753.499.3.camel@vabanque>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
	<200209192208.40254.jbr.1@gmx.net> <200209192215.g8JMEv306270@pfn1.pefnos>
	<200209221321.g8MDLb009922@pfn1.pefnos>  <20020922005310.B35@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020922005310.B35-muQmgwBScQHrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On nie, 2002-09-22 at 02:53, Pavel Machek wrote:
> Hi!
> > One more point is that the 'stable' configuration cannot sleep. Is that 
> > normal, since the "pci=notacpi" is set? When I
> > 'echo [1|4] > /proc/acpi/sleep'
> > the speaker beeps, nothing gets logged and nothing happens.
> 
> can we remove /proc/acpi/sleep so users don't waste time trying to make 
> s3/s4 work in 2.4.x?

S1 works fine and uses /proc/acpi/sleep. Removing it would be a step
backward...

-- 
Maciek




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
