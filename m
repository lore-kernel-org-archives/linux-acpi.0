From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH v3] ACPI / video: Add systems that should
 favor native backlight interface
Date: Tue, 21 Jan 2014 12:11:12 +0000
Message-ID: <1390306271.5320.4.camel@x230>
References: <1390053249-18919-1-git-send-email-i.gnatenko.brain@gmail.com>
	<52DCDA75.2000108@intel.com> <1390224857.10605.0.camel@x230>
	<52DDDA64.90407@intel.com> <1390274270.5320.2.camel@x230>
	<52DE067A.60400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <52DE067A.60400@intel.com>
Content-Language: en-US
Content-ID: <AFF98283EBF9814E920F026255E917C9@namprd05.prod.outlook.com>
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

On Tue, 2014-01-21 at 13:32 +0800, Aaron Lu wrote:
> On 01/21/2014 11:17 AM, Matthew Garrett wrote:
> > We know that Windows 8 graphics drivers don't use the ACPI interface,
> > and that systems change their behaviour as a result, in some cases with
> > absolutely no way for the ACPI interface could possibly work. I haven't
> > seen any cases where that's obviously true for any non-Windows 8
> 
> Perhaps I'm not clear, I didn't mean non-Windows 8 systems will all favor
> GPU's interface, I just meant for one specific win7 laptop I could re-use
> the existing code to make the GPU's interface as the only one left. And to
> achieve this, the Win8 OSI check in acpi_video_verify_backlight_support
> has to be gone.

We could do that, but why do we think that's the correct fix? The plan
is to remove the native list entirely and do this for all Windows 8
systems, so the Win8 OSI check is the right thing to do.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
