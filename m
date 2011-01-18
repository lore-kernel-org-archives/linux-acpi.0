From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI video: add initial blacklist to use vendor
	drivers for backlight
Date: Tue, 18 Jan 2011 19:44:42 +0000
Message-ID: <20110118194442.GA30606@srcf.ucam.org>
References: <1295376114-5685-1-git-send-email-herton@mandriva.com.br> <1295376114-5685-2-git-send-email-herton@mandriva.com.br> <20110118185659.GA29173@srcf.ucam.org> <20110118172457.600e8974@gotham.conectiva> <20110118193051.GA30169@srcf.ucam.org> <20110118173718.02fd4157@gotham.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110118173718.02fd4157@gotham.conectiva>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 18, 2011 at 05:37:18PM -0200, Herton Ronaldo Krzesinski wrote:
> On Tue, 18 Jan 2011 19:30:51 +0000
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > Ugh. Ok, how does this work on Windows?
> 
> On a provided by vendor windows image, the default brightness slider in windows
> didn't worked too... only a vendor supplied utility is able to change the
> brightness.

Awesome. Any chance you can provide the acpidump output for one of these 
machines? I'd prefer to find a more elegant solution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
