From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Fujitsu P2120 S3 resume - no video, lost PCI config, suggestions?
Date: Wed, 5 Mar 2003 16:07:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030305150729.GJ7861@poup.poupinou.org>
References: <ebw3cm26i25.fsf_-_@lxplus004.cern.ch> <Pine.LNX.4.33.0303041422450.1438-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303041422450.1438-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Ole Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 04, 2003 at 02:26:55PM -0600, Patrick Mochel wrote:
> 
> On 4 Mar 2003, Ole Rohne wrote:
> 
> > In my quest to make S3 working on this platform, I've found the
> > underlying reason why the display is black after a S3: the vga adapter
> > (ATI Radeon M6 LY) looses its pci configuration and comes back with io
> > and memory disabled, and BASE_ADDRESS_n, LATENCY_TIMER,
> > CACHE_LINE_SIZE, and INTERRUPT_LINE containing garbage. At first I
> > felt let down by the BIOS, but on reading the ACPI spec it seems that
> > it is up to the OS to enumerate and configure devices on "known" buses.
> > 
> > So far I've tried calling pci_save_state/pci_restore_state from within
> > the radeonfb pci driver suspend/resume routines. Unfortunately, that
> > causes the machine to hang, probably just after PCI_COMMAND has been
> > updated. Alternatively, I've tried rewriting the PCI configuration
> > from userspace (setpci), which doesn't always hang but now the thing
> > claims there is nothing connected when I eg reload radeonfb.
> > 
> > Questions:
> > Is it really the job of the OS to configure PCI devices after a S3 sleep?
> 
> Yes. That's what the suspend()/resume() callbacks are for in the drivers. 
> 
> > What is the reason for the hanging when I try to restore PCI config?
> 
> I'm not sure. You're definitely writing on something that you shouldn't. 
> What are you passing to pci_{save,restore}_state()? Are you giving it a 
> buffer or not? 
> 
> > Is it possible that PCI "enumeration" and configuration needs to be
> > done early, like in real mode or before irqs are enabled?
> 
> No. There's no need to do it that early. We should be able to handle most 
> (read: sane) devices with interrupts enabled. If there are devices that 
> need to be quieted with interrupts off, their resume() methods should do 
> so during the first pass (RESUME_POWER_ON).
> 

There are more things to do when you want to save/restore video devices,
as for example saving the framebuffer.  There are some code already
present in some fb drivers, but for openfirmware use.  Perhaps we
should as well enable them in general.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
