From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH V6 4/5] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Date: Tue, 20 Sep 2016 08:08:39 -0500
Message-ID: <20160920130839.GA13855@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-5-git-send-email-tn@semihalf.com>
 <20160919154550.GA13775@localhost>
 <d06879a2-d6e9-5d62-77c5-47eff33d9584@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d06879a2-d6e9-5d62-77c5-47eff33d9584@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org, linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, liudongdong3@huawei.com, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com, msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 20, 2016 at 09:06:23AM +0200, Tomasz Nowicki wrote:
> On 19.09.2016 17:45, Bjorn Helgaas wrote:
> >On Fri, Sep 09, 2016 at 09:24:06PM +0200, Tomasz Nowicki wrote:
> >>ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
> >>compliant with ECAM standard. It uses non-standard configuration space
> >>accessors (see pci_thunder_pem_ops) and custom configuration space granulation
> >>(see bus_shift = 24). In order to access configuration space and
> >>probe PEM as ACPI based PCI host controller we need to add MCFG quirk
> >>infrastructure. This involves:
> >>1. Export PEM pci_thunder_pem_ops structure so it is visible to MCFG quirk
> >>   code.
> >>2. New quirk entries for each PEM segment. Each contains platform IDs,
> >>   mentioned pci_thunder_pem_ops and CFG resources.
> >>
> >>Quirk is considered for ThunderX silicon pass2.x only which is identified
> >>via MCFG revision 1.
> >
> >Is it really the case that silicon pass2.x has MCFG revision 1, and
> >silicon pass1.x has MCFG revision 2?  That just seems backwards.
> 
> It is weird but silicon pass2.x is more common and it had MCFG
> revision 1 from the beginning. Unless it is allowed to use MCFG
> revision 0 ? Then we could use MCFG revision 0 for pass1.x

There's no reason to avoid revision 0.  The question is really what
firmware is already in the field.  We need to accommodate that.  We don't
want a situation where kernel version X only works with firmware version Y,
but kernel version X+1 only works with firmware version Y+1.

Bjorn
