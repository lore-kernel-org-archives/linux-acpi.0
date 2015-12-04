From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 3/3] dell-wmi: Improve unknown hotkey handling
Date: Thu, 3 Dec 2015 16:07:21 -0800
Message-ID: <20151204000721.GF1800@malice.jf.intel.com>
References: <cover.1448931589.git.luto@kernel.org>
 <b409d60963f81611e398b492a73ffd998414cd68.1448931589.git.luto@kernel.org>
 <20151203233856.GC1800@malice.jf.intel.com>
 <CALCETrXq3MNAWLWRR47-dW4XhOZCdsMOX=Jz7-frCCb88C8Czg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXq3MNAWLWRR47-dW4XhOZCdsMOX=Jz7-frCCb88C8Czg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 03, 2015 at 03:45:11PM -0800, Andy Lutomirski wrote:
> On Thu, Dec 3, 2015 at 3:38 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Mon, Nov 30, 2015 at 05:02:01PM -0800, Andy Lutomirski wrote:
> >> If DMI lists a hotkey that we don't recognize, log and ignore it
> >> instead of trying to map it to keycode 0.  I haven't seen this happen,
> >> but it will help maintain the key map in the future and it will help
> >> avoid sending bogus events.
> >>
> >> This also improves the message that we log when we get an unknown key
> >> event.
> >>
> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> ---
> >
> > Please include the individual patch changelogs here under --- in the patch
> > itself - this helps me build confidence that I am indeed looking at the right
> > patch and the expected changes are here.
> 
> Will do in the future -- different maintainers have different
> preferences here, I think.

Oh really?

This is the documented process in Documentation/SubmittingPatches Section 14)
The canonical patch format...

-- 
Darren Hart
Intel Open Source Technology Center
