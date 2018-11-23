From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
Date: Fri, 23 Nov 2018 11:21:00 -0800
Message-ID: <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
 <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
 <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com>
 <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anshuman Khandual <anshuman.khandual@arm.com>, Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 11/22/18 10:42 PM, Anshuman Khandual wrote:
> Are we willing to go in the direction for inclusion of a new system
> call, subset of it appears on sysfs etc ? My primary concern is not
> how the attribute information appears on the sysfs but lack of it's
> completeness.

A new system call makes total sense to me.  I have the same concern
about the completeness of what's exposed in sysfs, I just don't see a
_route_ to completeness with sysfs itself.  Thus, the minimalist
approach as a first step.
