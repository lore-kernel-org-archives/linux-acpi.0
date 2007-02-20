From: Corey Minyard <minyard@acm.org>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Tue, 20 Feb 2007 07:55:36 -0600
Message-ID: <45DAFDD8.909@acm.org>
References: <200702102327.28312.lenb@kernel.org>
	<200702152103.54960.bjorn.helgaas@hp.com>
	<45D53DDE.5000300@acm.org>
	<200702192131.52947.bjorn.helgaas@hp.com>
	<45DA9931.80605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <45DA9931.80605@linux.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Sender: openipmi-developer-bounces@lists.sourceforge.net
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, openipmi <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Bjorn Helgaas wrote:
>> On Thursday 15 February 2007 22:15, Corey Minyard wrote:
>>  
>>> Bjorn Helgaas wrote:
>>>    
>>>> On Saturday 10 February 2007 21:27, Len Brown wrote:
>>>>        
>>>>> acpi_find_bmc() appears to be searching for multiple SPMI tables 
>>>>> in the RSDT and running
>>>>> try_init_acpi() on each of them
>>>>> until it doesn't find any more.
>>>>>             
>>>> I can't remember why we look at the SPMI table(s) rather than
>>>> registering a normal ACPI (or even PNP) driver.  Unless we
>>>> need to poke the BMC very early, wouldn't it be better to
>>>> rely on the device description in the namespace?
>>>>         
>>> For some strange reason the normal ACPI information does not
>>> have all the information needed by the driver.  It doesn't have
>>> register size or spacing information.
>>>     
>>
>> I guess that would be a defect in the way ACPI is being used,
>> wouldn't it?  A PNP ID should define the device programming
>> model, including things like register size and spacing.  It
>> sounds like somebody didn't define a new PNP ID when he should
>> have.  I wonder whether it's worth trying to fix this.
>>
>>   
> Yes, it is considered an ACPI fault. Could you please describe in 
> detail, which registers miss the information? And probably your 
> acpidump will help as well.
I don't have a machine with an ACPI description of the BMC.  I'll copy 
the mailing list to see if anyone has an ACPI-described BMC.

I don't know that much about ACPI, so maybe that information is 
described somehow in a way the IPMI spec doesn't talk about directly, 
like in the _CRS object.

-Corey

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
