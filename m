From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: [2.6.1-rc1] no acpi event for ac_adapter?
Date: Thu, 8 Jan 2004 12:44:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040108124434.589abfcf.mike@it-loops.com>
References: <200401080904.30574.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200401080904.30574.lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 8 Jan 2004 09:04:44 +0100
Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org> wrote:

> [Please CC Me, I'm not subscribed on this list]
> 
> Hello List,
> 
> I was just wondering - should there normally be an acpi event for the
> plugging or removing of the ac-adapter? I've catted /proc/acpi/events,
> but the only thing I seem to be getting acpi events for is the
> powerbutton and my lid button.
> 
> System: Acer TravelMate 803LCI.
> Kernel: 2.6.1-rc1 with radeonfb patch from -mm1, and ircomm module
> autoloading patch (taken from irda website)
> 

Hi, I have the same notebook as you have, albeit a little different
model 800LCi.
I am not getting AC-adapter events as well if I unplug the ac-adapter,
BUT I am getting events for both batteries. Do you get them as well?

On a side note. Can you tell me how you got the radeonfb driver working
with your card.
I tried several different patches, but I either get distorted output or
no output ad all.


/Michael


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
