From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection
 mechanism firstly to detect IPMI system interface
Date: Wed, 09 Jun 2010 22:12:35 -0500
Message-ID: <4C105823.90301@acm.org>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
	<1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
	<1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
	<20100607125213.GA8277@srcf.ucam.org>
	<1275960531.3718.77.camel@localhost.localdomain>
	<20100608013453.GA5167@srcf.ucam.org>
	<1275973808.3718.99.camel@localhost.localdomain>
	<4C0F9264.8000008@acm.org>
	<1276137295.4564.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-reply-to: <1276137295.4564.22.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: ykzhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

ykzhao wrote:
> My first thought is to put the ACPI-IPMI opregion handler into ACPI
> subsystem. But Bjorn suggests that it can be put into the smi code. Then
> I follow his suggestion.
>
> OK. I will rewrite the code and don't tie the ACPI-IPMI opregion handler
> to the smi code.
>   
I think it's ok to be in the ipmi directory, just not directly with the 
SMI code.  I'd put it in its own file, I think.

>     
>   
>> Can you look and see if there is some other way to detect the ACPI 
>> function on a BMC with some other mechanism?  I think that would be 
>> better all around.  If it's the same BMC, the I can't imagine it matters 
>> if you send the messages via the PCI-detected or ACPI-detected mechanisms.
>>     
>
> OK. I will think about it again and try to figure out one solution that
> identify the same BMC via PCI-detected or ACPI-detected and avoids
> adjusting the discovery order. 
>   
Thanks.  If there's some unique message for this function that 
idempotent, you can simply send that message and see if you get an error 
response or not.  This is used for detection ATCA function in some 
cases, for instance.

-corey

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
