From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
Date: Wed, 17 Dec 2014 09:08:44 +0000
Message-ID: <CAGCh1+mEVsdVxnyBdoHg1LfY4=frL8_S=bD=jTepLbcxJKcDQA@mail.gmail.com>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <20141216154842.GI19412@leverpostej> <5490D042.3060901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5490D042.3060901@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Al Stone <al.stone@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 17 December 2014 at 00:37, Al Stone <al.stone@linaro.org> wrote:
>> I have not seen good guidelines on the usage of _DSD in that respect,
>> and I'm worried we'll end up with clock controllers half-owned by AML
>> and half-owned by the kernel's clock framework, and this separation
>> varying from board to board (and FW revision to FW revision). I think
>> that needs to be clarified at the ACPI spec level in addition to
>> anything we have in the kernel documentation.
>
> Hrm.  The spec (section 6.2.5) basically says that there exists a
> thing called _DSD and that when invoked, it returns a UUID followed
> by a data structure.  A separate document (on http://www.uefi.org/acpi)
> for each UUID defines the data structure it corresponds to.  The only
> one defined so far is for device properties:
>
>
> http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm
>
> I think you are suggesting good guidelines for both, yes?  The usage
> of new UUIDs and data structures, along with the usage of device
> properties for the UUID we have, right?  I've been trying to write
> such a thing but all I've accomplished so far is throwing away a
> couple of drafts that got ugly.  I'll keep at it, though.
>

Of course the way the spec is written also gives us the option, if the
OEMs and kernel guys and MS all agree on a different format for
aarch64 then all that is needed is a new UUID and we are no longer
tied to trying to insert DT into ACPI. I personally think this is the
way to go, I do not like the blindly copying DT into ACPI. I suspect
the information that a ACPI platform "needs" is probably significantly
simplified compared to some of the DT bindings.

Graeme
