From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH v3] ACPI / video: Add systems that should
 favor native backlight interface
Date: Tue, 21 Jan 2014 03:17:51 +0000
Message-ID: <1390274270.5320.2.camel@x230>
References: <1390053249-18919-1-git-send-email-i.gnatenko.brain@gmail.com>
	<52DCDA75.2000108@intel.com> <1390224857.10605.0.camel@x230>
	<52DDDA64.90407@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <52DDDA64.90407@intel.com>
Content-Language: en-US
Content-ID: <9712A04C2E3DEE42BE8F45FFB40B87A1@namprd05.prod.outlook.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: "aaron.lu@intel.com" <aaron.lu@intel.com>
Cc: "james@albanarts.com" <james@albanarts.com>, "bitbucket@online.de" <bitbucket@online.de>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "kvalo@adurom.com" <kvalo@adurom.com>, "corsac@debian.org" <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "ben@bjencks.net" <ben@bjencks.net>, "jrg.otte@gmail.com" <jrg.otte@gmail.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Martin@lichtvoll.de" <Martin@lichtvoll.de>, "thirdwiggin@gmail.com" <thirdwiggin@gmail.com>, "bugs@ttyhoney.com" <bugs@ttyhoney.com>, "jplatte@naasa.net" <jplatte@naasa.net>, "seth.forshee@canonical.com" <se>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2014-01-21 at 10:24 +0800, Aaron Lu wrote:
> On 01/20/2014 09:34 PM, Matthew Garrett wrote:
> > On Mon, 2014-01-20 at 16:12 +0800, Aaron Lu wrote:
> > 
> >> 1 remove the win8 OSI check, I've seen win7 laptops that also needs to
> >>   have only the GPU interface left and checking win8 doesn't make much
> >>   sense now;
> > 
> > Are we sure that those aren't simply some other bug?
> 
> Well, the firmware on that laptop makes use of EC to do backlight
> control and the fact that the firmware interface doesn't work while the
> GPU's work seems to indicate that the backlight control circuit is not
> routed to EC. I think this is the same case as Win8 laptops.

We know that Windows 8 graphics drivers don't use the ACPI interface,
and that systems change their behaviour as a result, in some cases with
absolutely no way for the ACPI interface could possibly work. I haven't
seen any cases where that's obviously true for any non-Windows 8
systems. EC interfaces that don't work are often due to Linux leaving
the hardware in a state other than the one expected by the firmware. We
shouldn't assume that it's the same issue until we've investigated
further.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
