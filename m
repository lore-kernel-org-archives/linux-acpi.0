From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Acer TM636 won't wakeup after S3, USB, i8042
Date: Fri, 21 Jan 2005 13:01:12 +0100
Message-ID: <20050121120112.GA11659@elf.ucw.cz>
References: <20050111003537.13142400@bonenpikster.drs.p> <20050117153245.GA1481@elf.ucw.cz> <20050117202517.3fa7b912@commensaal.drs.p>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050117202517.3fa7b912-7SZEXzPdWeU90gtriz95AQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Reading some positive reports on S3 on a travelmate 632, I gave it
> > > another try with my 636. After adding the acpi_sleep=s3_bios (thanks
> > > mizu) I got some visual signs of resume for the first time. But then
> > > the process halts. If I include USB support in the kernel, I get the
> > > following msgs
> > > 
> > > ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 11 (level,low) -> IRQ 11
> > > PCI: ENabeling device 0000:00:0b.0 (0080->0083)
> > > ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level,low) -> IRQ 10
> > > 
> > > And then it stops. Removing USB support gets me a bit further, now
> > > the process ends with:
> > > 
> > > i8042.c: Can't read CTR while initializing i8042.
> > > resume failed: i8042.c (Not sure about this line, typing it from
> > > memory)
> > > 
> > > 
> > > Is there anything I can do to help to debug this? I attached lspci
> > > -vvv, if there's any other log I can send, just ask.
> > 
> > Remove keyboard support and see what happens?
> 
> Then it will be a little hard for me to type: "echo 3 >
> /proc/acpi/sleep"

Network or scripts... init=/tmp/whatever_forces_it_to_sleep

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
