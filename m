From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 08:22:01 -0500
Message-ID: <41F101F9.7030705@bartol.udel.edu>
References: <F760B14C9561B941B89469F59BA3A84708CBB988@orsmsx401.amr.corp.intel.com> <20050121100618.GA3945@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050121100618.GA3945-Ji7FXtOmRLs@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Simon Fowler <simon-Ji7FXtOmRLs@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Simon Fowler wrote:
> On Thu, Jan 20, 2005 at 02:04:16PM -0800, Grover, Andrew wrote:
> 
>>>>From a distribution point of view, it would be nice to:
>>>
>>>a) Not have to rewrite every acpi battery applet to use the sbs
>>>interface directly, and
>>>b) Not have to have a database of hardware that has a smart battery
>>>
>>>Is there any way to provide the legacy interface even if standard
>>>battery support is built in, or alternatively some way of probing the
>>>system to determine which battery module should be loaded?
>>
>>Hasn't anyone written a libpower yet? Battery applets shouldn't be
>>groveling around proc, they should be making library calls. OK all
>>existing apps would need to be changed (probably a big code reduction
>>actually) but this would let the library look for both CM and sbs
>>interfaces (which should not pretend to be a CMBatt of course) and
>>handle them.
>>
> 
> From my perspective (I'm the current maintainer of the wmacpi
> battery monitor dockapp), all this would be much much easier if
> there was some documentation of what exactly all the files in
> /proc/acpi /mean/. I've had to root around in the kernel source to
> work out what some of it does. 

Even then, what the *kernel* does can be misleading or incorrect. For 
instance, in /proc/acpi/battery/BAT0/info, the "battery technology" 
field should be reporting "primary" or "secondary", based on the 
information it gets from the appropriate DSDT control methods (_BIF, I 
think). However, the implementor of battery.c has misread the ACPI spec 
to mean that "primary" always denotes "non-rechargeable", and 
"secondary" always denotes "rechargeable".

This led to my previous laptop, which had a control-method primary 
battery, reporting the battery as non-rechargeable -- when of course it 
wasn't.

This really does highlight why a proper library is needed for battery 
access -- both to hide the details of whether the battery is CM-based or 
SB-based, but also to remove the additional layer of obfustication added 
by proc.

cheers

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
