From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 20:47:39 +0400
Message-ID: <4447BB2B.1060407@linux.intel.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com> <20060420164419.GA30317@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751101AbWDTQrw@vger.kernel.org>
In-Reply-To: <20060420164419.GA30317@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Thu, Apr 20, 2006 at 08:33:26PM +0400, Alexey Starikovskiy wrote:
>> Xavier Bestel wrote:
>>> There are keyboards with power/sleep buttons. It makes sense they have
>>> the same behavior than ACPI buttons.
>> Agree, make them behave like ACPI buttons -- remove them from input stream, 
>> as they do not belong there...
> 
> Making the atkbd driver punt certain scancodes to the ACPI layer 
> /really/ isn't the right answer.
> 
Yes, this is why I mentioned using kevent and dbus before... Could it be the righter answer?
