From: Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: Administration Wishlist
Date: 22 Aug 2002 02:20:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1029975625.6527.86.camel@U414>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi guys,
    watching the nice little flamewar progressing over who, when and
whynot the latest acpi patches aren't backported for the latest stable
kernel release I thought it might be a good time to post my thoughts on
what is going right and wrong for ACPI development in my own personal
wishlist.


Problem: The current 2.4.19 backport issue

  This is what Linus was warning against a month or so back when he had
his little grump about the rarity of acpi kernel merges. The fact is
ACPI in the kernel is so far behind, average users NEED to patch their
kernel to get APCI to work (especially with these newfangled "ACPI does
all" things). The thing about average users is most of them use a fairly
modern, stable, linux kernel (At the moment that is either 2.4.18 or
2.4.19) and they don't have the knowhow/patience or courage to fiddle
around if a patch doesn't work as expected. 

Solutions : 

(1) As promised, get ACPI in the kernel vaguely up to date by merging
regularly as promised.

(2) Release a 2.4.19 backport of a (or the most) recent acpi-patch. Put
it on the sourceforge page, and recrute yourself a couple of extra
testers (and get the people who just want ACPI in their stable kernel
off your back).

Problem : Documentation is very sparse in most areas.

(1) There is little or no documentation in a lot of the code (remember
me grumbling about osl.c? Hacks to replace the DSDT were in completely
the wrong place because the description of what the function in osl.c
did was hidden in a file in the tables subdirectory).

(2) There is no description of how the spec. is being implimented.
(acpi_os_table_override seems half implemented. It is hardwired to
return AE_OK, what meaningful codes could otherwise be returned is
beyond my understanding of the code, why divert the newtable pointer to
NULL if the override was rejected makes less sense, why there's no
function definition to explain these things is beyond me)
 
(3) There's no desctiption of how other programs can access the
interface. the /proc/acpi tree is somewhat of an enigma to most people.
Most code at the moment merely hardcodes whatever the contents of the
authors own /proc/acpi happenned to be (since there's no obvious
descriptions of what is/will be implimented here). The last time I
looked at acpid, I had no idea what to put in the config file, since I
couldn't find a description of what event codes to expect.

Solutions:

(1) Get documentation into the code so that there is at least the
opportunity for people to write globally useful patches, rather than
just hacks for individual platforms. If something is semi-implimented,
explain what it is intended to do and what it's currently hardwired to
do. (Take a look at the way functions in tbget.c are documented, that's
the sort of code that bugs disappear from).

(2) Cobble together a description of what will be implimented in each
module, why, and how the various functions are implemented and should be
expected to interact. This could either be in the the source code, in a
"how things should interact spec" or as part of an overall
implementation spec. included in a HOWTO for interfacing with the ACPI
subsystem.

(3) Put together a "Interfacing with the ACPI subsystem HOWTO", take it
from the ACPI spec, the code documentation and/or the description of how
functions should be implemented. 


Problem : Everyone wants to do cutting edge development.

     The current activity on the mailing list suggests there are a few
dedicated individuals hacking new code, one or two cleaning up existing
code, about a dozen building hacks to get various bits and pieces
working for their platform and lots of people trying to get their PC to
work as advertised. What is lacking is someone to orchestrate the whole
shebang. 

Solution : Someone needs to step up and volunteer to give up most of
their current hacking to instead focus on delegating tasks, releasing
patches, assigning bugs and generally keeping everything running
smoothly. 
  I've seen numerous posts from people with patches trying to get
feedback on their work, get someone to accept it and threatening to
submit it to Linus directly for acceptance into the kernel tree. Give
the almighty administrative overlord the power to accept/reject patches,
everyone will know who to send patches to, hopefully get some feedback
on what they're doing and maybe getting the code documentation up to
scratch can be pushed at the same time...
  NOTE: At the moment the de-facto person in this position seems to be
Andrew Grover, I'm not sure if he wants to take over maintaining
everything, or get back to hacking code full time. As the userbase grows
I'd suggest whoever is maintaining things will get less and less time to
hack code, or ready themselves for more and more emails flaming them for
neglecting the administrative side of things. (take a look at
http://people.debian.org/~branden/ if you dont believe me that taking
responsiblity for widely used code is going to be stressful).


Problem : There is no bugtracking system.

The ACPI-devel mailing list is an all in one, developers conference,
users help forum, bug reporting system, general chat forum and dating
service. If I have a bug, I have to read the archives for half an hour
to find out if anybody knows about it, if anyone solved it, if anyone's
working on it, who that person might be and if anybody else experienced
the same problem. 

Solution : Sourceforge has a bugtracking system, why not use it. There
are also other alternative bugtracking applications. A bugtracking
system and someone doing a little bit of occasional administration could
organise and keep track of who has bugs, who's working on them and which
bugs can be bundled together. 


Problem : The ACPI code is getting useful, useable and widely used.

If you buy a new laptop, search the internet for how to set up linux,
the odds are the page you find will say "patch the kernel with the
latest ACPI patch". A lot of people use the acpi code, a lot more want
to use the acpi code but are waiting for stable releases, a lot more
people in the future are going to want to use acpi related code. They
will find bugs, they will find features you didn't intend, they will
want to thank someone for making it finally work.

Solution : Keep working hard, get support and administration
orchestrated properly and maybe set a sticky "ACPI is fantastic"
bugthread in the bugtracking subsystem. Users find the bugs, users help
isolate the bugs, developers get to take the credit for the great code
and users have somewhere to put all their thankyou messages.




>From my point of view, the ACPI code userbase has jumped significantly
over the last few months and the current administrative system isn't
coping. The point of this wishlist is to get people thinking and
hopefully volunteering towards overcoming the shortcomings in these
areas of administration. To this end, questions, comments and feedback
would probably be a good idea. 

Huw.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
