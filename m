From: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 19:22:16 +0100
Message-ID: <cone.1258309336.428593.1656.1000@eeekiste>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	<71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	<cone.1258211472.464906.1633.1000@eeekiste>
	<71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	<cone.1258285991.924736.2588.1000@eeekiste>
	<4AFFF7B8.2070508@tuffmail.co.uk>
	<20091115160201.GC1019@srcf.ucam.org>
	<4B00283C.3040807@tuffmail.co.uk>
	<20091115161458.GA1653@srcf.ucam.org>
	<20091115181631.GB3013@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Matthew Garrett writes:

> On Sun, Nov 15, 2009 at 04:14:58PM +0000, Matthew Garrett wrote:
>> On Sun, Nov 15, 2009 at 04:11:40PM +0000, Alan Jenkins wrote:
>> 
>> > We don't really look at the device though.  What we look at is the value  
>> > of WLDG.
>> >
>> > Stray notifications on either of the _other_ 2 pcie ports would then  
>> > cause us to toggle them based on WLDG.
>> >
>> > I see a _Lxx handler in my DSDT which looks like it notifies on _all_  
>> > the pcie ports.  So I think it's a bit tricky.
>> 
>> We could be smarter about that. WLDG is handy but not required - at the 
>> most basic level we could do a pci configuration space access and see if 
>> we get back 0xff or a value.
> 
> Though, thinking about it, you're right - we still need to know whether 
> it was a wifi device so we know whether to update the rfkill status. Do 
> Atheros devices still have their PCI class set to ethernet rather than 
> wireless?

cat /sys/bus/pci/devices/0000\:02\:00.0/class
0x028000

> 
> -- 
> Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
