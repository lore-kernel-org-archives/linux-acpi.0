From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Tue, 18 Jan 2005 10:39:36 -0500
Message-ID: <41ED2DB8.70707@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu> <1105747983.7368.3.camel@tyrosine> <47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu> <20050118102635.GV19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050118102635.GV19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> On Mon, Jan 17, 2005 at 10:03:25PM -0500, Rich Townsend wrote:
> 
>>What could be going wrong? Some thoughts:
>>*) maybe there is already a driver registered for SMBus alarms, that 
>>prevents them from getting through?
>>*) I'm assuming its already there, but maybe the functionality described 
>>in 5.6.2.2.2 actually needs to be implemented in the i2c-acpi-ec code?
> 
> 
> Exactly.  This must be implemented in i2c-acpi-ec, and a event notifier
> sohuld be done in order to pass this to the children.  Also I have to
> modify i2c-acpi-ec in order to make this driver event driven (we write to
> the PCRTL, then wait for an event (query number will be 0x20 in this
> perticular case) from the EC before processing further), and in the
> handler, if the alarm bit is set, then notify the child.
> That what I meant in a previous mail with 'overriden the _Q20',
> by the fact that I think its only a dummy alarm ack in order to be
> sure the smbus is still functionnal even if the OS do not provide
> a driver for accessing the smbus.  I never meant to do this in DSDT.
> I'm sorry for the confusion.

OK, thanks for the clarification. Out of interest, how do I install 
event handlers for the EC? A quick look through ec.c doesn't show any 
obvious way to do it.

> 
> 
>>*) perhaps the battery simply isn't generating the alarms?
> 
> 
> This may be another trouble.

Yeah, I think that may be the real problem. Even without proper alarm 
handling in i2c-acpi-ec, the alarms sent by the battery should still 
show up in the _Q20 method I hacked into my DSDT. Is it possible to fake 
an SMBus alarm, to track whether it is getting through the EC driver 
code properly

cheers,

Rich



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
