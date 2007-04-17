From: Corey Minyard <minyard@acm.org>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Tue, 17 Apr 2007 17:50:05 -0500
Message-ID: <46254F1D.1050903@acm.org>
References: <200702102327.28312.lenb@kernel.org>
	<20070225215922.GA28931@lists.us.dell.com>
	<5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
	<200704131144.32051.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <200704131144.32051.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Sender: openipmi-developer-bounces@lists.sourceforge.net
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jordan_Hargrave@dell.com, linux-acpi@vger.kernel.org, Matt_Domsch@dell.com, alexey.y.starikovskiy@linux.intel.com, openipmi-developer@lists.sourceforge.net, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Monday 26 February 2007 11:30, Jordan_Hargrave@dell.com wrote:
>   
>>   Here is the patch (RHEL5 base code) I've been testing that detects the ACPI namespace object.
>> The IPI0001 device doesn't contain the register spacing directly; it has a _CRS resource object that
>> (for KCS) has two I/O port entries.  I save the first port in io.addr_data, then calculate the register spacing based on subtracting the 2nd port address and the 1st.
>>     
>
> Whatever happened with this patch?  I think we should pursue it, but
> I don't see it in -mm.
>
> Bjorn
>   
Sorry, I was under the impression that more work was required here
dealing with the irqs.  Is that not the case?

-corey

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
