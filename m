From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Don't disable interrupts during EC access
Date: Tue, 16 Nov 2004 23:21:03 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC082@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>On Tue, Nov 16, 2004 at 12:16:16PM +0000, Matthew Wilcox wrote:
>> On Tue, Nov 16, 2004 at 02:15:47PM +0800, Yu, Luming wrote:
>> > Andi,
>> >=20
>> > This patch seems to break the atomic operation.
>> > The original code enclosed by=20
>spin_lock_irqsave/spin_unlock_irqresotre is trying to make=20
>sure the first operation to EC_COMMAND
>> > register , and the second operation to EC_DATA register=20
>belong to one atomic transaction.
>>=20
>> Why would converting from a spinlock to a semaphore break this?
>
>As Willy said the operation should be still atomic in respect to
>the register.

It is just due to odd hardware behavior.  :-)
For example, if you want to read data from EC.  The first step
is writing 0x80 (read command) to ec command register.
Then, if EC (hardware) write data into the output buffer, the
output buffer flag (OBF) in the status register is set.
(I assume it is within 1ms). According to ACPI spec,
now, EC interrupt will get triggered. And this is
firmware generated edge interrupt. It will hold until OBF get reset.
When the host processor reads this data from the output buffer,=20
the OBF can be reset.

So, if you remove the spin_lock_irqsave, when OBF is set
you could get interrupt storm. =20

For detail, please refer to ACPI spec :
12   ACPI Embedded Controller Interface Specification.

>
>And the event polling can take several ms, there is just no way=20
>to do this during runtime with interrupts off. Especially since
>thermal will do this every few seconds. With my patch at least=20
>only kacpid is blocked for that long, not the whole system.
>
>-Andi
>

As for thermal event, AFAIK,  not all laptops use EC to generate thermal
event. And I'm thinking of a algorithm.

  There is a issue of kacpid consuming a lot of CPU time, which should=20
be due to GPEs keep firing without any control. Current GPE handling
just
re-enable GPEs after handling GPEs without considering any semantics=20
conveyed by that GPE.  For example,  some laptop could keep generating=20
thermal GPE interrupt, if temperature is above a threshold. All these
thermal events
is just telling OS one thing, that is "temperature is above a specific
threshold,
 please turn on cooling methods ...." .  Maybe this is platform issue,
 but driver  should handle this case smoothly.
=20
http://bugme.osdl.org/show_bug.cgi?id=3D3686
=20

Thanks
Luming



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
