From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi
	notifier hook functions
Date: Tue, 27 Jul 2010 22:30:53 -0500
Message-ID: <4C4FA46D.1090402@acm.org>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com>
	<1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
	<201007261052.04772.bjorn.helgaas@hp.com>  <4C4E340E.3050003@acm.org>
	<1280279356.13929.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-reply-to: <1280279356.13929.139.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: ykzhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

On 07/27/2010 08:09 PM, ykzhao wrote:
>
>> I agree that a notifier framework seems like massive overkill for this
>> interface.  I will note that there are already interfaces for
>> registering to receive callbacks when an IPMI device is added or
>> removed.  What's missing is a way to ask "Is this an ACPI PNP device?".
>>      
> Not sure whether the ipmi_smi_watcher is the interfaces you mentioned?
>
> The ipmi_smi_watcher is already used in the second patch in order to
> create the user interface. But now the callback function of new_smi only
> provides very limited info about the IPMI device. In order to assure
> that ACPI can communicate with the IPMI device, I have to compare the
> corresponding device pointer to confirm whether this is what ACPI want
> to communicate. Then I tried the several mechanisms to make it work
> while touch IPMI code/structure as little as possible.
>       >manually discover the pnp device with the pnpid of "IPI0001"
>       >using one notifier in course of loading IPMI pnp device driver.
>       >Merge the opregion code into the PNP IPMI discovery code.
>    
Yes ipmi_smi_watcher is the interface, and you obviously have to use 
that to catch the interfaces as the come and go.

>
>    
>> Since this same function will be needed for IPMI SMBus interfaces, if
>> that ever becomes a reality in the kernel, it seems more reasonable to
>> provide some type of addition to the IPMI interface to be able to store
>> this in the low-level code and retrieve this from the IPMI user
>> interface.  So you can use the standard mechanisms to watch for devices
>> being added, and then query to see if they are PNP at that point.
>>
>> Does that make sense?
>>      
> Yes. If this interface can be available, it will be easier for me to
> write the patch to enable that the ACPI can communicate with the BMC.
>    
I was actually hoping you would provide that interface :).  I'm not sure 
exactly what you need, but it's not that hard, really.  A new function 
in ipmi.h and ipmi_msghandler.c which calls a new function pointer in 
struct ipmi_smi_handlers (in ipmi_smi.h).  ipmi_si.c would tie into that 
new function pointer, and I believe all the data is already available there.

-corey

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
