From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eee-laptop: Register as a pci-hotplug device
Date: Sun, 26 Apr 2009 22:51:08 +0200
Message-ID: <71cd59b00904261351k18a8bc0cue076c1bb44da4813@mail.gmail.com>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain>
	 <20090209234911.GB862@elte.hu>
	 <5030E21460%linux@youmustbejoking.demon.co.uk>
	 <20090210150431.GA26798@srcf.ucam.org>
	 <5030E7CFF4%linux@youmustbejoking.demon.co.uk>
	 <20090419015614.GA6926@srcf.ucam.org>
	 <71cd59b00904190020x7d946c29w736d89fc27d39594@mail.gmail.com>
	 <20090419151306.GA15048@srcf.ucam.org>
	 <71cd59b00904250712k332bfc14nb181aaabd7c605e5@mail.gmail.com>
	 <20090426171640.GA9633@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756661AbZDZU6Z@vger.kernel.org>
In-Reply-To: <20090426171640.GA9633@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Darren Salt <linux@youmustbejoking.demon.co.uk>
List-Id: linux-acpi@vger.kernel.org

On Sun, Apr 26, 2009 at 7:16 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> Hm. I /think/ that version leaks notification handlers on the failure
> path. Does this look ok? I don't have an eee to hand right now, so can't
> test this at the moment.
I'll test it tomorow, but it seems ok.
Thanks

-- 
Corentin Chary
http://xf.iksaif.net
