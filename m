From: Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>
Subject: Re: Pushing ACPI to 2.4.20?
Date: Wed, 25 Sep 2002 11:07:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020925100716.GA16721@the.earth.li>
References: <3D90E44B.2030400@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D90E44B.2030400-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
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

---- Original Message ----
> From ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org <ahaning@mindspring.com>
> Date: Tuesday, 24 Sep 2002, 23:16
>
> Perhaps I'm misunderstanding something or I just do not know what I'm 
> doing WRT ACPI on my machine. I don't understand why there would be any 
> push to get ACPI in the mainstream kernel when it seems that the major 
> goal for now is just booting and assigning IRQs.

There are various reasons for this:

* Power management.  Some modern laptops do not support apm - they don't
idle properly, monitor temperature and turn their fan on and off, report
battery status, throttle the CPU or switch off unless you use ACPI.

* To provide a basis for patches such as swsusp that provides
suspend-to-disk, and for projects such as those working to support 
speedstep.

* IIRC some architectures require ACPI to assign IRQs to boot properly.

It is also predominantly the same code that is used in the 2.5.x kernels 
where suspend-to-RAM and suspend-to-disk are supported and given the 
above bullet points it is worth making as much as possible of this 
functionality available to 2.4.x users.

The first point is probably the most crucial.  If you have one of many
modern laptops and want to be able to use it for purposes other than
frying eggs and seeing quite how quickly it is possible to drain a
battery but don't want to brave 2.5.x then you're left with no choice
but 2.4.x+ACPI patchs.

I dare say there are other reasons I've missed here.

-- 
Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
