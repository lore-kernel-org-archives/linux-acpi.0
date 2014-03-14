From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: 3.14-rc: /proc/acpi/battery gone?
Date: Fri, 14 Mar 2014 17:29:41 -0400
Message-ID: <CAKb7Uvi-GfOu3_3BMU_Cu4qYS8PQRWzxVm1XETY7y_TJjGPs_A@mail.gmail.com>
References: <20140314211456.GA23213@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140314211456.GA23213@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 14, 2014 at 5:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> It seems /proc/acpi/battery interface is gone, and I don't see any
> option to reintroduce it... what is going on?

The interface went away in a semi-recent kernel release (3.13 or
3.12), breaking pretty much every battery app. (Admittedly the
interface was marked as deprecated for quite some time, but that
didn't stop everyone from using it and not caring about the new
thing.) I've yet to find a windowmaker dock app that works with the
current sysfs API :(

  -ilia
