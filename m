From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [linux-usb-devel] kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 11:04:40 -0800 (PST)
Message-ID: <20050105190441.77206.qmail@web50205.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501051254530.635-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0501051254530.635-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB development list <linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

Yes, I completely forgot, but here it is:
before suspend, without any devices plugged:
HC status
  usbcmd    =     0008   Maxp32 EGSM 
  usbstat   =     0020   HCHalted 
  usbint    =     000f
  usbfrnum  =   (1)278
  flbaseadd = 173d8278
  sof       =       40
  stat1     =     0080  
  stat2     =     0080  
Frame List
Skeleton QH's

After resume, without any devices plugged:
HC status
  usbcmd    =     0008   Maxp32 EGSM 
  usbstat   =     0020   HCHalted 
  usbint    =     000f
  usbfrnum  =   (0)344
  flbaseadd = 173d8344
  sof       =       40
  stat1     =     0080  
  stat2     =     0080  
Frame List
Skeleton QH's

After resume, with a device plugged:
HC status
  usbcmd    =     00c1   Maxp64 CF RS 
  usbstat   =     0000   
  usbint    =     000f
  usbfrnum  =   (0)eb8
  flbaseadd = 173d8eb8
  sof       =       40
  stat1     =     0080  
  stat2     =     0093   ConnectChange Connected
Frame List
Skeleton QH's

After resume, with that device pulled:
HC status
  usbcmd    =     00c1   Maxp64 CF RS 
  usbstat   =     0000   
  usbint    =     000f
  usbfrnum  =   (0)1d0
  flbaseadd = 173d81d0
  sof       =       40
  stat1     =     0080  
  stat2     =     0082   ConnectChange
Frame List
Skeleton QH's

After resume, with that device plugged again in the
second USB socket:
HC status
  usbcmd    =     00c1   Maxp64 CF RS 
  usbstat   =     0000   
  usbint    =     000f
  usbfrnum  =   (1)b20
  flbaseadd = 173d8b20
  sof       =       40
  stat1     =     0093   ConnectChange Connected
  stat2     =     0082   ConnectChange
Frame List
Skeleton QH's

All this time, lsusb gives:
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  


After rmmod uhci-hcd/insmod uhci-hcd:
HC status
  usbcmd    =     00c1   Maxp64 CF RS 
  usbstat   =     0000   
  usbint    =     000f
  usbfrnum  =   (1)e38
  flbaseadd = 16ea4e38
  sof       =       40
  stat1     =     0095   Enabled Connected
  stat2     =     0080  
Frame List
Skeleton QH's
- skel_int128_qh
    [d6e7a240] link (16e7a152) element (16e73040)
      0: [d6e73040] link (00000001) e3 IOC Active NAK
Length=7ff MaxLen=0 DT0 EndPt=1 Dev=2, PID=69(IN)
(buf=16e8c020)

and now a lsusb gives:
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 004: ID 067b:2303 Prolific Technology,
Inc. PL2303 Serial Port
Bus 002 Device 003: ID 067b:2305 Prolific Technology,
Inc. PL2305 Parallel Port
Bus 002 Device 002: ID 04cc:1122 Philips
Semiconductors Hub
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  

I did those tests without ehci-hcd loaded, and the
irqs are like this:
cat /proc/interrupts 
           CPU0       
  0:    8713857          XT-PIC  timer
  1:       1313          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        977          XT-PIC  eth0, uhci_hcd
  7:       3935          XT-PIC  uhci_hcd, uhci_hcd
  8:          1          XT-PIC  rtc
  9:        605          XT-PIC  acpi
 12:      25196          XT-PIC  i8042
 14:      68981          XT-PIC  ide0
 15:      77706          XT-PIC  ide1
NMI:          0 
ERR:          0

The tested USB is on IRQ 7.

Thanks,
Paul

--- Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:

> On Wed, 5 Jan 2005, Paul Ionescu wrote:
> 
> > Hi Bjorn,
> > 
> > I tried with "pci=routeirq" but the same
> behaviour.
> > Then I isolate uhci_hcd to be alone on IRQ 9, and
> I
> > can see that after a susp/resume cycle, the irq 9
> > count is still incrementing, but lsusb shows no
> new
> > device.
> > If I rmmod/insmod the uhci-hcd at this point, it
> > works.
> > So I think is not an IRQ problem.
> > 
> > Thanks,
> > Paul
> 
> Have you been able to see what information is in the
> debugging file, 
> /proc/driver/uhci/[controller ID]?
> 
> Alan Stern
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
