From: Abheek Anand <abheek-VX+DGZyGJwM3uPMLIKxrzw@public.gmane.org>
Subject: Re: presario 1505us battery not found
Date: Sat, 26 Apr 2003 14:35:26 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030426183526.GA11530@cs.umd.edu>
References: <200304261058.DAA12435@ptolemy.la.asu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200304261058.DAA12435-iy676YoZKZKAgX/H7s3LlTe48wsgrGvP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kevin Schmidt <w9cf-iy676YoZKZKAgX/H7s3LlTe48wsgrGvP@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Well it does the trick on my hardware. I am now able to check up on battery
status etc. Next step is trying to get suspend to work ;-)

Thanks a lot
Abheek

On (04/26/03 03:58), Kevin Schmidt wrote:
> I am running a 2.4.19 kernel and acpi20020918, on a compaq evo1000v.
> Many things may have improved since then. I finally gave up and patched
> the dsdt to always report the battery present. I was then able to get
> the battery charge status etc.; I changed:
> Return (local1)
> to
> Return (Or (local1,0x10))
> in my C10F method, to set the battery present bit. I don't know if this
> name is the same in other compaq dsdts.
> 
> > Date: Thu, 24 Apr 2003 15:49:43 -0400
> > From: Abheek Anand <abheek-VX+DGZyGJwM3uPMLIKxrzw@public.gmane.org>
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Organization: CS Department, University of Maryland
> > Subject: [ACPI] presario 1505us battery not found
> > 
> > Hi,
> > 
> > After quite a bit of tinkering with my presario 1505us, I managed to get most
> > of what I need up and working. Currently im using linux 2.5.67 with
> > acpi-20030328. I am able to get ac-adaptor information, and the LID works
> > fine. However, I am unable to get acpi to recognize my battery, which it
> > always shows as absent. I have looked at several people's suggestions on this
> > on the mailing list, but none of them work for me.
> > 
> > I'm including a copy of the dmesg messages my system spews out. I also did the
> > usual dsdt disassemble, fix, and include in kernel routine. I have put up my
> > original (and fixed) dsdt on http://www.cs.umd.edu/~abheek/acpi . My
> > /proc/acpi/battery/BAT1 entries show the battery as absent.
> > 
> > Any help would be _very_ appreciated.
> > 
> > Thanks,
> > Abheek
> > 
> =-------------------------------------------------------------
> Kevin Schmidt, w9cf-iy676YoZKZKAgX/H7s3LlTe48wsgrGvP@public.gmane.org, http://fermi.la.asu.edu/w9cf
> Department of Physics and Astronomy
> Arizona State University, Tempe, AZ 85287-1504
> (480) 965-8240 Fax: (480) 965-7954
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

Abheek


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
