From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Regression 2.6.39-rc1 for sony-laptop
Date: Fri, 01 Apr 2011 20:30:18 +0300
Message-ID: <4D960BAA.3020700@iki.fi>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com> <20110401172241.GA26851@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110401172241.GA26851@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, error27@gmail.com, malattia@linux.it, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 01.04.2011 20:22, Matthew Garrett wrote:
> On Fri, Apr 01, 2011 at 07:16:43PM +0200, Andrea Gelmini wrote:
> 
>> Git bisect blames this commit:
> 
> Pretty convinced that git bisect's got that wrong, given that it doesn't 
> touch any Sony code. I'll take a look at the Sony patches, thanks for 
> the report!

The same issue was posted yesterday on platform-driver-x86@ as "NULL
pointer dereference in sony-laptop" by Alessandro Guido, with a
preliminary patch from Mattia Dongili:

http://thread.gmane.org/gmane.linux.drivers.platform.x86.devel/1720

-- 
Anssi Hannula
