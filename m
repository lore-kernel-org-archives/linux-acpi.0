From: Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Subject: Re: RE: ACPI interrupts..
Date: Wed, 25 Sep 2002 14:42:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020925144232.607831f9.jcollins@asgardsrealm.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEBC@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DEBC-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Sep 2002 09:50:22 -0700 "Grover, Andrew"
<andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: Linus Torvalds [mailto:torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org] 
> > ie why does my dual P4-HT take ~18,000 interrupts per second on each 
> > virtual CPU?
> 
> A bug, apparently...
> 
> I take it this is a new phenomena?

I reported something similar last month:

  http://sourceforge.net/mailarchive/message.php?msg_id=2019388

Never found a solution, other than not running ESD or ASD.

-- 
Jamin W. Collins


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
