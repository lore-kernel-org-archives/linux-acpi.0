From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: Fw: Re: [2.6.1-rc1] no acpi event for ac_adapter?
Date: Thu, 8 Jan 2004 14:03:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040108140327.6ffe7506.mike@it-loops.com>
References: <20040108125732.1dadfa7d.mike@it-loops.com>
	<200401081343.30673.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200401081343.30673.lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 8 Jan 2004 13:43:30 +0100
Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org> wrote:

> On Thursday 08 January 2004 12:57, Michael Guntsche wrote:
> >
> > Hi, I have the same notebook as you have, albeit a little different
> > model 800LCi.
> > I am not getting AC-adapter events as well if I unplug the ac-adapter,
> > BUT I am getting events for both batteries. Do you get them as well?
> 
> Yup. That works.
Good. If you want to do something if you unplug the AC-Adapter you only have to
wait for a battery event and then check "/proc/acpi/ac_adapter/ACAD/state".
It's not as simple as waiting for an ac-adapter event, but it works too.


> I just took the radeonfb patch from mm1 (on kernel.org), applied it to my 
> tree, compiled it in the kernel, and rebooted. After the switch to graphics 
> mode there's some garbage on top of the screen, but after that it works 
> perfectly.
> 

Thanks a lot, with this patch my FB actually works again.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
