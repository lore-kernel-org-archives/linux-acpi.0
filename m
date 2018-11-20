From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Tue, 20 Nov 2018 14:42:43 -0700
Message-ID: <20181120214243.GG26707@localhost.localdomain>
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com, baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2018 at 04:02:21PM -0500, Sinan Kaya wrote:
> On 11/20/2018 3:44 PM, Alex_Gagniuc@Dellteam.com wrote:
> > I'd prefer "sure" instead of "think". "I think it breaks some system I'm
> > not telling you about" doesn't help much in figuring out how not to
> > break said system(s).:)
> 
> Sorry, I thought I mentioned why it would break but let me repeat.
> 
> The systems I have seen rely on the HEST table presence as an indicator
> to the OS that firmware first is enabled. If you go look at the _OSC bits
> on such systems, it still says OS owns the AER service.
> 
> The assumption here is that HEST table has precedence over the _OSC bits.
> That's what needs to be clarified in the UEFI forum.
> 
> If this code is to go in and ignore the HEST table presence, then firmware
> will think that it owns AER service and OS will think that it owns AER
> service too.

How does that work? If the OS takes control, it sets up MSIs that FW don't
react to, and disables system errors through PCIe Root Control. Aren't
those sys errs the mechanism FW knows it has something to do, which
means the OS can effectively fence it off?
