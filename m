From: Henrik Brix Andersen <brix@gimp.org>
Subject: Re: [Ipw2100-devel] Re: [ACPI] ibm-acpi-0.3
Date: Wed, 18 Aug 2004 15:23:02 +0200
Sender: linux-thinkpad-admin@linux-thinkpad.org
Message-ID: <1092835382.11535.6.camel@sponge.fungus>
References: <20040810080826.GD28939@aero.ensim.com>
	 <20040814211247.GS20883@aero.ensim.com>
	 <20040817091921.GI20883@aero.ensim.com>
	 <1092807746.25902.155.camel@dhcppc4>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
In-Reply-To: <1092807746.25902.155.camel@dhcppc4>
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: Len Brown <len.brown@intel.com>
Cc: Borislav Deianov <borislav@users.sourceforge.net>, ACPI Developers <acpi-devel@lists.sourceforge.net>, linux-thinkpad@linux-thinkpad.org, ipw2100-devel List <ipw2100-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, 2004-08-18 at 07:42, Len Brown wrote:
> > http://bkernel.sf.net/tmp/ibm-acpi-0.3.tar.gz
> 
> The radio hot key sends an ACPI event,
> and the acpid example calls this radio.sh:
> 
> #!/bin/bash
> 
> if ! /sbin/rmmod ipw2100; then
>         /sbin/service network restart
> fi
> 
> 
> Does this means that the button press magically changed
> the state of the radio in hardware?  I didn't see any
> processing inside the driver to do that.

No. The listed radio.sh script just unloads the ipw2100 module from
memory which effectively disables the wireless network connection.

Regards,
Brix
-- 
Henrik Brix Andersen <brix@gimp.org>

-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
