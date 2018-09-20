From: Luciano Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi/iwlwifi: thermal thermal_zone3: failed to read out thermal
 zone (-61)
Date: Thu, 20 Sep 2018 18:01:06 +0300
Message-ID: <c95de2e727357c8f24330ee35fab9e7036b2aab4.camel@intel.com>
References: <CA+icZUXxcxZvyo7ge33E_1PSnjUs7Lq=BdcX2rbB6pYka1S=cA@mail.gmail.com>
         <1b3e46335094bda8dfef48c74adf2d027e9417ca.camel@intel.com>
         <CA+icZUVUkLZxqqNocBg27_Q=xvtDbfuW7z1ZcDx+WNO0uDwuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+icZUVUkLZxqqNocBg27_Q=xvtDbfuW7z1ZcDx+WNO0uDwuOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2018-09-20 at 16:45 +0200, Sedat Dilek wrote:
> On Thu, Sep 20, 2018 at 4:34 PM, Luciano Coelho
> <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > On Thu, 2018-09-20 at 15:42 +0200, Sedat Dilek wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > 
> > > I am seeing this with Linux v4.18.y and v4.19-rc4.
> > > 
> > > Investigating thermal_zone3...
> > > 
> > > # cat /sys/devices/virtual/thermal/thermal_zone3/type
> > > iwlwifi
> > > 
> > > I have the following iwlwifi device and firmware installed...
> > > 
> > > [   10.476589] iwlwifi 0000:04:00.0: loaded firmware version
> > > 36.e91976c0.0 op_mode iwlmvm
> > > [   10.519441] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band
> > > Wireless AC 8265, REV=0x230
> > > 
> > > What informations do you need and how can I help?
> > 
> > This is normal, though annoying, and was discussed before.  The
> > thermal
> > framework is trying to read the temperature as soon as the zone is
> > registered and this causes that warning.  Our device only provides
> > the
> > temperature when the device goes up, so reading before that will
> > always
> > fail.
> > 
> 
> OK, I understand.
> Thanks.

Thanks for your interest in helping! :)

--
Cheers,
Luca.
